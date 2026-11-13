import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_event.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/data/photo_file_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/services/app_settings_service.dart';
import 'package:minimo_photo/services/screen_awake_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  for (final enabled in [true, false]) {
    test('screen awake during compression: $enabled', () async {
      SharedPreferences.setMockInitialValues({});
      final settings = AppSettingsService.instance;
      final previous = settings.preventScreenSleep;
      settings.preventScreenSleep = enabled;
      addTearDown(() => settings.preventScreenSleep = previous);
      final awake = _RecordingScreenAwakeService();
      final bloc = CompressBloc(
        initialPhotos: const [
          PickedPhoto(
            path: '/tmp/original.jpg',
            name: 'original.jpg',
            size: 100,
          ),
        ],
        photoCompressorAdapter: _SuccessfulCompressor(),
        screenAwakeService: awake,
      );
      addTearDown(bloc.close);

      bloc.add(const CompressStarted());
      await bloc.stream.firstWhere(
        (state) => state.status == CompressStatus.done,
      );
      expect(awake.calls, enabled ? [true, false] : isEmpty);
    });
  }

  test('screen awake setting defaults on and persists', () async {
    SharedPreferences.setMockInitialValues({});
    final settings = AppSettingsService.instance;
    await settings.load();
    expect(settings.preventScreenSleep, isTrue);
    await settings.setPreventScreenSleep(false);
    await settings.load();
    expect(settings.preventScreenSleep, isFalse);
    await settings.setPreventScreenSleep(true);
  });

  test('location removal defaults off and persists', () async {
    SharedPreferences.setMockInitialValues({});
    final settings = AppSettingsService.instance;
    await settings.load();
    expect(settings.removeLocation, isFalse);
    await settings.setRemoveLocation(true);
    await settings.load();
    expect(settings.removeLocation, isTrue);
    await settings.setRemoveLocation(false);
  });

  test('replacement saves compressed photo before deleting original', () async {
    SharedPreferences.setMockInitialValues({});
    final files = _RecordingPhotoFileAdapter();
    final bloc = CompressBloc(
      initialPhotos: const [
        PickedPhoto(
          path: '/tmp/original.jpg',
          name: 'original.jpg',
          size: 100,
          sourceIdentifier: 'asset-1',
          canPreserveMetadata: true,
          canDeleteOriginal: true,
        ),
      ],
      photoFileAdapter: files,
      photoCompressorAdapter: _SuccessfulCompressor(),
    );
    addTearDown(bloc.close);

    bloc.add(const CompressStarted());
    await bloc.stream.firstWhere(
      (state) => state.status == CompressStatus.done,
    );

    bloc.add(
      const CompressResultsSaved(
        preserveMetadataSourceIdentifiers: {'asset-1'},
        deleteSourceIdentifiers: {'asset-1'},
      ),
    );
    final saved = await bloc.stream.firstWhere(
      (state) => state.isSaved && !state.isSaving,
    );

    expect(files.calls, ['save replacement', 'delete original']);
    expect(saved.savedPhotoCount, 1);
    expect(saved.deletedOriginalCount, 1);

    final settledAfterRepeat = bloc.stream
        .skipWhile((state) => !state.isSaving)
        .firstWhere((state) => !state.isSaving);
    bloc.add(
      const CompressResultsSaved(
        preserveMetadataSourceIdentifiers: {'asset-1'},
        deleteSourceIdentifiers: {'asset-1'},
      ),
    );
    final settled = await settledAfterRepeat;
    expect(settled.isSaved, isTrue);
    expect(settled.saveError, isNull);
    expect(files.calls, ['save replacement', 'delete original']);
  });

  test('unavailable original reports both warnings', () async {
    SharedPreferences.setMockInitialValues({});
    final files = _RecordingPhotoFileAdapter()
      ..denyAccess = true
      ..warnings = ['album_unavailable'];
    final bloc = CompressBloc(
      initialPhotos: const [
        PickedPhoto(
          path: '/tmp/original.jpg',
          name: 'original.jpg',
          size: 100,
          sourceIdentifier: 'asset-1',
        ),
      ],
      photoFileAdapter: files,
      photoCompressorAdapter: _SuccessfulCompressor(),
    );
    addTearDown(bloc.close);

    bloc.add(const CompressStarted());
    await bloc.stream.firstWhere(
      (state) => state.status == CompressStatus.done,
    );
    bloc.add(
      const CompressResultsSaved(
        preserveMetadataSourceIdentifiers: {'asset-1'},
        deleteSourceIdentifiers: {'asset-1'},
      ),
    );
    final saved = await bloc.stream.firstWhere(
      (state) => state.isSaved && !state.isSaving,
    );

    expect(files.calls, ['save replacement', 'delete original']);
    expect(saved.saveError, isNull);
    expect(saved.metadataError, isNotNull);
    expect(saved.deleteError, isNotNull);
    expect(saved.deletedOriginalCount, 0);
  });

  test(
    'save failure logs native details and keeps originals for retry',
    () async {
      SharedPreferences.setMockInitialValues({});
      final logs = <String>[];
      final previousPrint = debugPrint;
      debugPrint = (message, {wrapWidth}) => logs.add(message ?? '');
      addTearDown(() => debugPrint = previousPrint);
      final failure = PlatformException(
        code: 'save_failed',
        message: 'Photos failed',
        details: {'domain': 'PHPhotosErrorDomain', 'code': 3302},
      );
      final files = _RecordingPhotoFileAdapter()..saveFailure = failure;
      final bloc = CompressBloc(
        initialPhotos: const [
          PickedPhoto(
            path: '/tmp/original.jpg',
            name: 'original.jpg',
            size: 100,
            sourceIdentifier: 'asset-1',
          ),
        ],
        photoFileAdapter: files,
        photoCompressorAdapter: _SuccessfulCompressor(),
      );
      addTearDown(bloc.close);
      bloc.add(const CompressStarted());
      await bloc.stream.firstWhere((s) => s.status == CompressStatus.done);
      const save = CompressResultsSaved(
        preserveMetadataSourceIdentifiers: {'asset-1'},
        deleteSourceIdentifiers: {'asset-1'},
      );
      bloc.add(save);
      final failed = await bloc.stream.firstWhere((s) => s.saveError != null);
      expect(failed.saveError, same(failure));
      expect(failed.isSaving, isFalse);
      expect(failed.hasUnsavedResults, isTrue);
      expect(files.calls, ['save replacement']);
      expect(logs.join('\n'), contains('save failed completed=0'));
      expect(logs.join('\n'), contains('PHPhotosErrorDomain'));
      expect(logs.join('\n'), contains('3302'));
      files.saveFailure = null;
      bloc.add(save);
      await bloc.stream.firstWhere((s) => s.isSaved && !s.isSaving);
      expect(files.calls, [
        'save replacement',
        'save replacement',
        'delete original',
      ]);
    },
  );
}

class _SuccessfulCompressor extends PhotoCompressorAdapter {
  @override
  Future<CompressionResult> compress(
    String inputPath,
    String originalName,
    CompressionSettings settings, {
    bool addMinimoPrefix = true,
    void Function(double progress)? onProgress,
  }) async {
    onProgress?.call(1);
    return const CompressionResult(
      success: true,
      originalSize: 100,
      outputSize: 50,
      outputPath: '/tmp/compressed.jpg',
    );
  }

  @override
  Future<int?> estimateCompressedSize(
    Iterable<PickedPhoto> photos,
    CompressionSettings settings, {
    bool Function()? isCancelled,
  }) async => 50;

  @override
  Future<String?> createThumbnail(String inputPath) async => null;
}

class _RecordingPhotoFileAdapter extends PhotoFileAdapter {
  final calls = <String>[];
  bool denyAccess = false;
  List<String> warnings = const [];
  Object? saveFailure;

  @override
  Future<GallerySaveResult> saveReplacement(
    String filePath,
    String sourceIdentifier, {
    String? album,
    String? captureDate,
    double? latitude,
    double? longitude,
  }) async {
    calls.add('save replacement');
    if (saveFailure case final error?) throw error;
    return GallerySaveResult(warnings: warnings);
  }

  @override
  Future<int> deleteOriginals(Iterable<String> sourceIdentifiers) async {
    calls.add('delete original');
    if (denyAccess) throw StateError('original unavailable');
    return sourceIdentifiers.length;
  }
}

class _RecordingScreenAwakeService extends ScreenAwakeService {
  final calls = <bool>[];

  @override
  Future<void> setEnabled(bool enabled) async => calls.add(enabled);
}
