import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/app_settings_service.dart';
import '../../../services/app_stats_service.dart';
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
  bool _cancelRequested = false;
  int _compressionRunId = 0;
  int _estimateRunId = 0;
  Timer? _estimateDebounce;

  CompressBloc({
    List<PickedPhoto> initialPhotos = const [],
    PhotoFileAdapter? photoFileAdapter,
    PhotoCompressorAdapter? photoCompressorAdapter,
    AppSettingsService? appSettings,
  }) : _photoFileAdapter = photoFileAdapter ?? PhotoFileAdapter(),
       _photoCompressorAdapter =
           photoCompressorAdapter ?? PhotoCompressorAdapter(),
       _appSettings = appSettings ?? AppSettingsService.instance,
       super(CompressState.initial(initialPhotos)) {
    on<CompressThumbnailsRequested>(_onThumbnailsRequested);
    on<CompressEstimateRequested>(_onEstimateRequested);
    on<CompressPhotosAdded>(_onPhotosAdded);
    on<CompressSimpleQualityChanged>(_onSimpleQualityChanged);
    on<CompressSettingsChanged>(_onSettingsChanged);
    on<CompressStarted>(_onStarted);
    on<CompressProgressChanged>(_onProgressChanged);
    on<CompressCancelled>(_onCancelled);
    on<CompressBackgrounded>((_, _) {});
    on<CompressForegroundResumed>((_, _) {});
    on<CompressResultsSaved>(_onResultsSaved);
    on<CompressMessagesCleared>(_onMessagesCleared);
    add(const CompressThumbnailsRequested());
    add(const CompressEstimateRequested());
  }

  @override
  Future<void> close() {
    _estimateDebounce?.cancel();
    return super.close();
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
    final estimate = await _photoCompressorAdapter.estimateCompressedSize(
      state.photos.map((photo) => photo.path),
      state.settings,
    );
    if (runId == _estimateRunId) {
      emit(state.copyWith(estimatedSize: estimate, clearEstimatedSize: true));
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
      if (index >= state.thumbnailPaths.length) return;
      final thumbnails = List<String?>.of(state.thumbnailPaths)..[index] = path;
      emit(state.copyWith(thumbnailPaths: thumbnails));
    }
  }

  void _onPhotosAdded(CompressPhotosAdded event, Emitter<CompressState> emit) {
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
      ),
    );
    _requestEstimate();
  }

  void _onSettingsChanged(
    CompressSettingsChanged event,
    Emitter<CompressState> emit,
  ) {
    emit(state.copyWith(settings: event.settings));
    _requestEstimate();
  }

  Future<void> _onStarted(
    CompressStarted event,
    Emitter<CompressState> emit,
  ) async {
    if (state.photos.isEmpty) return;
    _cancelRequested = false;
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
        results: const [],
        photoStatuses: statuses,
        compressionRunId: runId,
        progress: 0,
        elapsed: Duration.zero,
        clearSaveNotification: true,
        clearCompressionError: true,
      ),
    );

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
    stopwatch.stop();
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
    emit(state.copyWith(status: CompressStatus.done, progress: 1));
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
    if (state.status != CompressStatus.processing) return;
    _cancelRequested = true;
    _compressionRunId++;
    await _photoCompressorAdapter.cancelCompression();
    await _deleteOutputs(state.results);
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
    if (state.isSaving || state.successfulOutputPaths.isEmpty) return;
    emit(state.copyWith(isSaving: true, clearSaveNotification: true));
    try {
      final album = _appSettings.savePhotosToAlbum
          ? AppSettingsService.albumName
          : null;
      for (final path in state.successfulOutputPaths) {
        await _photoFileAdapter.saveToGallery(path, album: album);
      }
      emit(
        state.copyWith(
          isSaving: false,
          savedPhotoCount: state.successfulOutputPaths.length,
          clearSaveNotification: true,
        ),
      );
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

  Future<void> _deleteOutputs(Iterable<CompressedPhoto> results) async {
    for (final path
        in results.map((item) => item.result.outputPath).whereType<String>()) {
      final file = File(path);
      if (await file.exists()) await file.delete();
    }
  }
}
