import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_event.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/data/photo_file_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/services/app_cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory root;
  late File source;
  late _Compressor codec;
  late CompressBloc bloc;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    root = await Directory.systemTemp.createTemp('batch_cleanup_');
    await Directory('${root.path}/picked_photos').create();
    await Directory('${root.path}/minimo_photo').create();
    source = await File(
      '${root.path}/picked_photos/source.jpg',
    ).writeAsBytes([1, 2]);
    codec = _Compressor(root);
  });
  tearDown(() async {
    await bloc.close();
    await root.delete(recursive: true);
  });

  void createBloc({PhotoFileAdapter? files, int count = 1}) {
    bloc = CompressBloc(
      batchCache: BatchCache(root: root),
      initialPhotos: List.generate(
        count,
        (i) => PickedPhoto(path: source.path, name: 'source$i.jpg', size: 2),
      ),
      photoCompressorAdapter: codec,
      photoFileAdapter: files,
    );
  }

  Future<void> compress() async {
    bloc.add(const CompressStarted());
    await bloc.stream.firstWhere((s) => s.status == CompressStatus.done);
  }

  test('keeps saved files on results; deletes entire batch on exit', () async {
    final gallery = await File('${root.path}/gallery.jpg').writeAsBytes([4]);
    final files = _Gallery(gallery);
    createBloc(files: files);
    await compress();
    bloc.add(const CompressResultsSaved());
    await bloc.stream.firstWhere((s) => s.isSaved);
    expect(await source.exists(), isTrue);
    expect(await codec.output(1).exists(), isTrue);
    expect(await codec.preview.exists(), isTrue);
    await bloc.close();
    expect(await source.exists(), isFalse);
    expect(await codec.output(1).exists(), isFalse);
    expect(await codec.preview.exists(), isFalse);
    expect(await gallery.exists(), isTrue);
  });

  test(
    'cancel waits for late output; retains imported source for retry',
    () async {
      codec.blockAt = 2;
      createBloc(count: 2);
      bloc.add(const CompressStarted());
      await codec.blocked.future;
      bloc.add(const CompressCancelled());
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state.status, CompressStatus.processing);
      expect(await codec.output(1).exists(), isTrue);
      codec.resume.complete();
      await bloc.stream.firstWhere((s) => s.status == CompressStatus.ready);
      expect(await source.exists(), isTrue);
      expect(await codec.output(1).exists(), isFalse);
      expect(await codec.output(2).exists(), isFalse);
      expect(bloc.state.results, isEmpty);
      await compress();
      expect(await codec.output(3).exists(), isTrue);
    },
  );

  test('close waits for save and share before deleting', () async {
    final gallery = await File('${root.path}/gallery.jpg').writeAsBytes([4]);
    final files = _Gallery(gallery)..gate = Completer<void>();
    createBloc(files: files);
    await compress();
    final shareDone = Completer<void>();
    final sharing = bloc.useFiles(() => shareDone.future);
    bloc.add(const CompressResultsSaved());
    await files.started.future;
    var closed = false;
    final closing = bloc.close().then((_) => closed = true);
    await Future<void>.delayed(Duration.zero);
    expect(closed, isFalse);
    expect(await source.exists(), isTrue);
    files.gate!.complete();
    await Future<void>.delayed(Duration.zero);
    expect(closed, isFalse);
    expect(await codec.output(1).exists(), isTrue);
    shareDone.complete();
    await sharing;
    await closing;
    expect(await codec.output(1).exists(), isFalse);
    expect(await gallery.readAsBytes(), [3]);
  });

  test('close waits for import, estimate and late preview', () async {
    codec.previewGate = Completer<void>();
    codec.estimateGate = Completer<void>();
    createBloc();
    await codec.previewStarted.future;
    await codec.estimateStarted.future;
    final imported = File('${root.path}/picked_photos/late.jpg');
    final importGate = Completer<void>();
    final importing = bloc.useFiles(() async {
      await importGate.future;
      await imported.writeAsBytes([5]);
      await bloc.retainPhotos([
        PickedPhoto(path: imported.path, name: 'late.jpg', size: 1),
      ]);
    });
    var closed = false;
    final closing = bloc.close().then((_) => closed = true);
    await Future<void>.delayed(Duration.zero);
    expect(closed, isFalse);
    importGate.complete();
    await importing;
    codec.estimateGate!.complete();
    await Future<void>.delayed(Duration.zero);
    expect(closed, isFalse);
    expect(await imported.exists(), isTrue);
    codec.previewGate!.complete();
    await closing;
    expect(await imported.exists(), isFalse);
    expect(await codec.preview.exists(), isFalse);
  });

  test(
    'background/resume retains active files; manual clear is guarded',
    () async {
      createBloc();
      await compress();
      bloc.add(const CompressBackgrounded());
      bloc.add(const CompressForegroundResumed());
      await Future<void>.delayed(Duration.zero);
      expect(await codec.output(1).exists(), isTrue);
      await expectLater(AppCacheService.clear(root: root), throwsStateError);
      expect(await source.exists(), isTrue);
      await bloc.close();
      await AppCacheService.clear(root: root);
    },
  );
}

class _Compressor extends PhotoCompressorAdapter {
  final Directory root;
  int calls = 0;
  int? blockAt;
  final blocked = Completer<void>();
  final resume = Completer<void>();
  Completer<void>? previewGate;
  Completer<void>? estimateGate;
  final previewStarted = Completer<void>();
  final estimateStarted = Completer<void>();
  _Compressor(this.root);
  File output(int n) => File('${root.path}/minimo_photo/output$n.jpg');
  File get preview => File('${root.path}/minimo_photo/preview.jpg');

  @override
  Future<CompressionResult> compress(
    String inputPath,
    String originalName,
    CompressionSettings settings, {
    bool addMinimoPrefix = true,
    void Function(double progress)? onProgress,
  }) async {
    final n = ++calls;
    await output(n).writeAsBytes([3]);
    if (blockAt == n) {
      blocked.complete();
      await resume.future;
    }
    return CompressionResult(
      success: true,
      outputPath: output(n).path,
      outputSize: 1,
      originalSize: 2,
    );
  }

  @override
  Future<String?> createThumbnail(String inputPath) async {
    if (!previewStarted.isCompleted) previewStarted.complete();
    await previewGate?.future;
    await preview.writeAsBytes([6]);
    return preview.path;
  }

  @override
  Future<int?> estimateCompressedSize(
    Iterable<PickedPhoto> photos,
    CompressionSettings settings, {
    bool Function()? isCancelled,
  }) async {
    if (!estimateStarted.isCompleted) estimateStarted.complete();
    await estimateGate?.future;
    return 1;
  }
}

class _Gallery extends PhotoFileAdapter {
  final File gallery;
  final started = Completer<void>();
  Completer<void>? gate;
  _Gallery(this.gallery);
  @override
  Future<void> saveToGallery(String filePath, {String? album}) async {
    started.complete();
    await gate?.future;
    await gallery.writeAsBytes(await File(filePath).readAsBytes());
  }
}
