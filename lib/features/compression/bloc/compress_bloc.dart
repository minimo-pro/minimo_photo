import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/app_settings_service.dart';
import '../../../services/app_cache_service.dart';
import '../../../services/app_stats_service.dart';
import '../../../services/screen_awake_service.dart';
import '../data/photo_compressor_adapter.dart';
import '../data/photo_file_adapter.dart';
import '../domain/compression_result.dart';
import '../domain/compression_settings.dart';
import '../domain/picked_photo.dart';
import 'compress_event.dart';
import 'compress_state.dart';

class CompressBloc extends Bloc<CompressEvent, CompressState> {
  final PhotoFileAdapter _photoFileAdapter;
  final PhotoCompressorAdapter _photoCompressorAdapter;
  final AppSettingsService _appSettings;
  final ScreenAwakeService _screenAwakeService;
  final BatchCache _cache;
  final _operations = <Future<void>>{};
  Future<void>? _closingFuture;
  bool _closing = false;
  Future<void>? _compressionOperation;
  bool _screenAwakeEnabled = false;
  bool _cancelRequested = false;
  int _compressionRunId = 0;
  int _estimateRunId = 0;
  Timer? _estimateDebounce;
  final _savedOutputPaths = <String>{};
  final _replacementSourceIdentifiers = <String>{};
  final _deletedSourceIdentifiers = <String>{};

  CompressBloc({
    BatchCache? batchCache,
    List<PickedPhoto> initialPhotos = const [],
    CompressionSettings initialSettings = const CompressionSettings(),
    PhotoFileAdapter? photoFileAdapter,
    PhotoCompressorAdapter? photoCompressorAdapter,
    AppSettingsService? appSettings,
    ScreenAwakeService? screenAwakeService,
  }) : _cache = batchCache ?? BatchCache(),
       _photoFileAdapter = photoFileAdapter ?? PhotoFileAdapter(),
       _photoCompressorAdapter =
           photoCompressorAdapter ?? PhotoCompressorAdapter(),
       _appSettings = appSettings ?? AppSettingsService.instance,
       _screenAwakeService = screenAwakeService ?? ScreenAwakeService.instance,
       super(CompressState.initial(initialPhotos, settings: initialSettings)) {
    _handle<CompressThumbnailsRequested>(_onThumbnailsRequested);
    _handle<CompressEstimateRequested>(_onEstimateRequested);
    _handle<CompressPhotosAdded>(_onPhotosAdded);
    _handle<CompressSimpleQualityChanged>(_onSimpleQualityChanged);
    _handle<CompressSettingsChanged>(_onSettingsChanged);
    _handle<CompressStarted>(_onStarted);
    _handle<CompressProgressChanged>(_onProgressChanged);
    _handle<CompressCancelled>(_onCancelled);
    on<CompressBackgrounded>((_, _) {});
    on<CompressForegroundResumed>((_, _) {});
    _handle<CompressResultsSaved>(_onResultsSaved);
    _handle<CompressMessagesCleared>(_onMessagesCleared);
    unawaited(useFiles(() => _cache.retain(initialPhotos.map((p) => p.path))));
    add(const CompressThumbnailsRequested());
    add(const CompressEstimateRequested());
  }

  void _handle<E extends CompressEvent>(
    FutureOr<void> Function(E, Emitter<CompressState>) handler,
  ) {
    on<E>((event, emit) async {
      if (_closing ||
          (event is CompressStarted &&
              state.status == CompressStatus.processing)) {
        return;
      }
      final operation = useFiles(() async => handler(event, emit));
      if (event is CompressStarted) _compressionOperation = operation;
      await operation;
    });
  }

  /// Imports, previews and the share sheet also hold a file lease.
  Future<T> useFiles<T>(Future<T> Function() operation) async {
    if (_closing) throw StateError('Batch is closing');
    final finished = Completer<void>();
    _operations.add(finished.future);
    try {
      return await operation();
    } finally {
      _operations.remove(finished.future);
      finished.complete();
    }
  }

  Future<void> retainPhotos(List<PickedPhoto> photos) =>
      _cache.retain(photos.map((photo) => photo.path));

  @override
  void add(CompressEvent event) {
    if (!_closing) super.add(event);
  }

  @override
  Future<void> close() async {
    try {
      await finishBatch();
    } finally {
      await super.close();
    }
  }

  // Close the state stream after widgets detach; paused listeners can delay it.
  Future<void> finishBatch() => _closingFuture ??= _closeBatch();

  Future<void> _closeBatch() async {
    _closing = true;
    _cancelRequested = true;
    _compressionRunId++;
    _estimateRunId++;
    _estimateDebounce?.cancel();
    await _photoCompressorAdapter.cancelCompression();
    await Future.wait(_operations.toList());
    await _setScreenAwake(false);
    await _cache.clear(release: true);
  }

  void _requestEstimate() {
    _estimateRunId++;
    _estimateDebounce?.cancel();
    _estimateDebounce = Timer(
      const Duration(milliseconds: 100),
      () => add(const CompressEstimateRequested()),
    );
  }

  Future<void> _onEstimateRequested(
    CompressEstimateRequested event,
    Emitter<CompressState> emit,
  ) async {
    if (state.status != CompressStatus.ready) return;
    final runId = ++_estimateRunId;
    emit(state.copyWith(isEstimating: true));
    final estimate = await _photoCompressorAdapter.estimateCompressedSize(
      state.photos,
      state.settings,
      isCancelled: () => runId != _estimateRunId || isClosed,
    );
    if (runId == _estimateRunId && !_closing && !emit.isDone) {
      emit(
        state.copyWith(
          estimatedSize: estimate,
          clearEstimatedSize: true,
          isEstimating: false,
        ),
      );
    }
  }

  Future<void> _onThumbnailsRequested(
    CompressThumbnailsRequested event,
    Emitter<CompressState> emit,
  ) async {
    final count = state.photos.length.clamp(0, 3);
    for (var index = 0; index < count; index++) {
      if (state.thumbnailPaths[index] != null) continue;
      final path = await _photoCompressorAdapter.createThumbnail(
        state.photos[index].path,
      );
      if (path != null) await _cache.retain([path]);
      if (_closing || emit.isDone || index >= state.thumbnailPaths.length) {
        return;
      }
      final thumbnails = List<String?>.of(state.thumbnailPaths)..[index] = path;
      emit(state.copyWith(thumbnailPaths: thumbnails));
    }
  }

  Future<void> _onPhotosAdded(
    CompressPhotosAdded event,
    Emitter<CompressState> emit,
  ) async {
    await retainPhotos(event.photos);
    if (_closing) return;
    if (state.status != CompressStatus.ready || event.photos.isEmpty) return;
    final identities = state.photos.map(_identity).toSet();
    final added = event.photos
        .where((photo) => identities.add(_identity(photo)))
        .toList();
    if (added.isEmpty) return;
    emit(
      state.copyWith(
        photos: [...state.photos, ...added],
        thumbnailPaths: [
          ...state.thumbnailPaths,
          ...List<String?>.filled(added.length, null),
        ],
        photoStatuses: [
          ...state.photoStatuses,
          ...List<PhotoCompressionStatus>.filled(
            added.length,
            PhotoCompressionStatus.waiting,
          ),
        ],
        clearEstimatedSize: true,
        isEstimating: true,
      ),
    );
    add(const CompressThumbnailsRequested());
    _requestEstimate();
  }

  String _identity(PickedPhoto photo) => '${photo.name}\u0000${photo.size}';

  void _onSimpleQualityChanged(
    CompressSimpleQualityChanged event,
    Emitter<CompressState> emit,
  ) {
    emit(
      state.copyWith(
        settings: CompressionSettings.forSimpleQuality(
          event.quality,
        ).copyWith(keepExif: state.settings.keepExif),
        isEstimating: true,
      ),
    );
    _requestEstimate();
  }

  void _onSettingsChanged(
    CompressSettingsChanged event,
    Emitter<CompressState> emit,
  ) {
    emit(state.copyWith(settings: event.settings, isEstimating: true));
    _requestEstimate();
  }

  Future<void> _onStarted(
    CompressStarted event,
    Emitter<CompressState> emit,
  ) async {
    if (state.photos.isEmpty || state.status == CompressStatus.processing) {
      return;
    }
    _savedOutputPaths.clear();
    _replacementSourceIdentifiers.clear();
    _deletedSourceIdentifiers.clear();
    _cancelRequested = false;
    _estimateRunId++;
    final runId = ++_compressionRunId;
    final stopwatch = Stopwatch()..start();
    final statuses = List<PhotoCompressionStatus>.filled(
      state.photos.length,
      PhotoCompressionStatus.waiting,
    );
    final results = <CompressedPhoto>[];
    final totalWeight = state.photos.fold<int>(
      0,
      (sum, photo) => sum + (photo.size > 0 ? photo.size : 1),
    );
    var completedWeight = 0;
    emit(
      state.copyWith(
        status: CompressStatus.processing,
        isEstimating: false,
        isSaved: false,
        results: const [],
        photoStatuses: statuses,
        compressionRunId: runId,
        progress: 0,
        elapsed: Duration.zero,
        clearSaveNotification: true,
        clearCompressionError: true,
      ),
    );

    await _setScreenAwake(_appSettings.preventScreenSleep);
    try {
      for (var index = 0; index < state.photos.length; index++) {
        if (_cancelRequested || runId != _compressionRunId) return;
        final photo = state.photos[index];
        statuses[index] = PhotoCompressionStatus.processing;
        emit(
          state.copyWith(
            processingIndex: index,
            photoStatuses: List.of(statuses),
            currentPhotoProgress: 0,
            elapsed: stopwatch.elapsed,
          ),
        );
        try {
          final result = await _photoCompressorAdapter.compress(
            photo.path,
            photo.name,
            state.settings,
            addMinimoPrefix: _appSettings.addMinimoPrefix,
            onProgress: (photoProgress) {
              if (_cancelRequested || runId != _compressionRunId) return;
              final overall =
                  (completedWeight + photo.size * photoProgress) / totalWeight;
              add(
                CompressProgressChanged(
                  runId: runId,
                  progress: overall,
                  currentPhotoProgress: photoProgress,
                  elapsed: stopwatch.elapsed,
                ),
              );
            },
          );
          if (result.outputPath case final output?) {
            await _cache.retain([output]);
          }
          if (_cancelRequested || runId != _compressionRunId) return;
          statuses[index] = result.success
              ? PhotoCompressionStatus.compressed
              : PhotoCompressionStatus.skipped;
          results.add(CompressedPhoto(source: photo, result: result));
        } catch (error) {
          if (_cancelRequested || runId != _compressionRunId) return;
          statuses[index] = PhotoCompressionStatus.failed;
          results.add(
            CompressedPhoto(
              source: photo,
              result: const CompressionResult(success: false),
            ),
          );
          emit(state.copyWith(compressionError: error));
        }
        completedWeight += photo.size > 0 ? photo.size : 1;
        emit(
          state.copyWith(
            results: List.of(results),
            photoStatuses: List.of(statuses),
            progress: completedWeight / totalWeight,
            elapsed: stopwatch.elapsed,
          ),
        );
      }
      final successfulResults = results
          .where((item) => item.result.success)
          .toList();
      if (successfulResults.isNotEmpty) {
        final originalSize = successfulResults.fold<int>(
          0,
          (sum, item) => sum + (item.result.originalSize ?? item.source.size),
        );
        final compressedSize = successfulResults.fold<int>(
          0,
          (sum, item) => sum + (item.result.outputSize ?? 0),
        );
        await AppStatsService.recordCompressions(
          photoCount: successfulResults.length,
          savedBytes: originalSize - compressedSize,
        ).onError((_, _) {});
      }
      if (!_closing && runId == _compressionRunId) {
        emit(state.copyWith(status: CompressStatus.done, progress: 1));
      }
    } finally {
      stopwatch.stop();
      await _setScreenAwake(false);
    }
  }

  void _onProgressChanged(
    CompressProgressChanged event,
    Emitter<CompressState> emit,
  ) {
    if (event.runId != _compressionRunId || _cancelRequested) return;
    if (event.progress < state.progress) return;
    emit(
      state.copyWith(
        progress: event.progress,
        currentPhotoProgress: event.currentPhotoProgress,
        elapsed: event.elapsed,
      ),
    );
  }

  Future<void> _onCancelled(
    CompressCancelled event,
    Emitter<CompressState> emit,
  ) async {
    if (state.status != CompressStatus.processing || _cancelRequested) return;
    _cancelRequested = true;
    _compressionRunId++;
    await _photoCompressorAdapter.cancelCompression();
    await _setScreenAwake(false);
    await _compressionOperation;
    await _cache.clear(
      keep: state.photos.map((photo) => photo.path).toSet()
        ..addAll(state.thumbnailPaths.whereType<String>()),
    );
    if (_closing) return;
    emit(
      state.copyWith(
        status: CompressStatus.ready,
        results: const [],
        photoStatuses: List<PhotoCompressionStatus>.filled(
          state.photos.length,
          PhotoCompressionStatus.waiting,
        ),
        processingIndex: 0,
        progress: 0,
        currentPhotoProgress: 0,
        elapsed: Duration.zero,
        clearCompressionError: true,
      ),
    );
  }

  Future<void> _onResultsSaved(
    CompressResultsSaved event,
    Emitter<CompressState> emit,
  ) async {
    if (state.isSaving) return;
    final successfulResults = state.successResults
        .where((item) => item.result.outputPath != null)
        .toList();
    if (successfulResults.isEmpty) return;
    final allowAdditionalCopy =
        state.isSaved &&
        event.preserveMetadataSourceIdentifiers.isEmpty &&
        event.deleteSourceIdentifiers.isEmpty;

    emit(state.copyWith(isSaving: true, clearSaveNotification: true));
    try {
      final metadataIdentifiers = event.preserveMetadataSourceIdentifiers;
      final deleteIdentifiers = event.deleteSourceIdentifiers;
      final album = _appSettings.savePhotosToAlbum
          ? AppSettingsService.albumName
          : null;
      final metadataWarnings = <String>[];
      var savedAnyPhoto = false;

      for (final item in successfulResults) {
        final outputPath = item.result.outputPath;
        if (outputPath == null) continue;
        final sourceIdentifier = item.source.sourceIdentifier;
        if (sourceIdentifier != null &&
            metadataIdentifiers.contains(sourceIdentifier)) {
          if (_replacementSourceIdentifiers.contains(sourceIdentifier)) {
            continue;
          }
          final save = await _photoFileAdapter.saveReplacement(
            outputPath,
            sourceIdentifier,
            album: album,
            captureDate: item.source.captureDate,
            latitude: item.source.latitude,
            longitude: item.source.longitude,
          );
          _replacementSourceIdentifiers.add(sourceIdentifier);
          _savedOutputPaths.add(outputPath);
          savedAnyPhoto = true;
          metadataWarnings.addAll(save.warnings);
        } else {
          if (_savedOutputPaths.contains(outputPath) && !allowAdditionalCopy) {
            continue;
          }
          await _photoFileAdapter.saveToGallery(outputPath, album: album);
          _savedOutputPaths.add(outputPath);
          savedAnyPhoto = true;
        }
      }

      if (deleteIdentifiers.isEmpty) {
        if (!savedAnyPhoto) {
          emit(state.copyWith(isSaving: false, clearSaveNotification: true));
          return;
        }
        emit(
          state.copyWith(
            isSaving: false,
            isSaved: true,
            savedPhotoCount: successfulResults.length,
            deletedOriginalCount: 0,
            metadataError: metadataWarnings.isEmpty
                ? null
                : metadataWarnings.join('; '),
            clearSaveNotification: true,
          ),
        );
        return;
      }

      var deletedOriginalCount = 0;
      try {
        final pendingIdentifiers = deleteIdentifiers.difference(
          _deletedSourceIdentifiers,
        );
        if (pendingIdentifiers.isEmpty) {
          emit(state.copyWith(isSaving: false, clearSaveNotification: true));
          return;
        }
        deletedOriginalCount = await _photoFileAdapter.deleteOriginals(
          pendingIdentifiers,
        );
        if (deletedOriginalCount == pendingIdentifiers.length) {
          _deletedSourceIdentifiers.addAll(pendingIdentifiers);
        }
        emit(
          state.copyWith(
            isSaving: false,
            isSaved: true,
            savedPhotoCount: successfulResults.length,
            deletedOriginalCount: deletedOriginalCount,
            metadataError: metadataWarnings.isEmpty
                ? null
                : metadataWarnings.join('; '),
            clearSaveNotification: true,
          ),
        );
      } catch (error) {
        emit(
          state.copyWith(
            isSaving: false,
            isSaved: true,
            savedPhotoCount: successfulResults.length,
            deletedOriginalCount: deletedOriginalCount,
            deleteError: error,
            metadataError: metadataWarnings.isEmpty
                ? null
                : metadataWarnings.join('; '),
            clearSaveNotification: true,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          saveError: error,
          clearSaveNotification: true,
        ),
      );
    }
  }

  void _onMessagesCleared(
    CompressMessagesCleared event,
    Emitter<CompressState> emit,
  ) => emit(state.copyWith(clearSaveNotification: true));

  Future<void> _setScreenAwake(bool enabled) async {
    if (enabled == _screenAwakeEnabled) return;
    _screenAwakeEnabled = enabled;
    try {
      await _screenAwakeService.setEnabled(enabled);
    } catch (_) {
      _screenAwakeEnabled = !enabled;
    }
  }
}
