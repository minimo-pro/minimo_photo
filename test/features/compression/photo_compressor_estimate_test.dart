import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('temporary output ownership', () {
    late Directory root;
    late File original;
    late _FakeCodec codec;
    late FlutterImageCompressPlatform previous;
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    setUp(() async {
      root = await Directory.systemTemp.createTemp('codec_cleanup_');
      original = await File(
        '${root.path}/original.jpg',
      ).writeAsBytes(List.filled(100, 1));
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async => root.path);
      previous = FlutterImageCompressPlatform.instance;
      codec = _FakeCodec()..outputSize = 50;
      FlutterImageCompressPlatform.instance = codec;
    });
    tearDown(() async {
      FlutterImageCompressPlatform.instance = previous;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
      await root.delete(recursive: true);
    });
    Future<CompressionResult> compress(PhotoCompressorAdapter adapter) =>
        adapter.compress(
          original.path,
          'same.jpg',
          const CompressionSettings(),
        );
    Future<List<File>> outputs() => Directory('${root.path}/minimo_photo')
        .list(recursive: true, followLinks: false)
        .where((e) => e is File)
        .cast<File>()
        .toList();

    for (final nullResult in [false, true]) {
      test(
        'removes partial output on ${nullResult ? 'null' : 'throw'}',
        () async {
          codec.nullOutput = nullResult;
          codec.throwAfterWrite = !nullResult;
          await expectLater(
            compress(PhotoCompressorAdapter()),
            throwsStateError,
          );
          expect(await outputs(), isEmpty);
          expect(await original.length(), 100);
        },
      );
    }
    test('removes late output after cancellation', () async {
      codec.gate = Completer<void>();
      final adapter = PhotoCompressorAdapter();
      final pending = compress(adapter);
      await codec.started.future;
      await adapter.cancelCompression();
      expect(await outputs(), hasLength(1));
      final failure = expectLater(pending, throwsStateError);
      codec.gate!.complete();
      await failure;
      expect(await outputs(), isEmpty);
      expect(await original.exists(), isTrue);
    });
    test('same names use independent directories', () async {
      final first = await compress(PhotoCompressorAdapter());
      final second = await compress(PhotoCompressorAdapter());
      expect(first.outputPath, isNot(second.outputPath));
      await File(first.outputPath!).delete();
      expect(await File(second.outputPath!).exists(), isTrue);
    });
    test('untrusted output path never deletes original', () async {
      codec.returnedPath = original.path;
      final adapter = PhotoCompressorAdapter();
      await expectLater(compress(adapter), throwsStateError);
      expect(await original.length(), 100);
      expect(await outputs(), isEmpty);
    });
  });

  test('estimate uses actual output and rejects savings below 10%', () async {
    final directory = await Directory.systemTemp.createTemp('minimo_test_');
    addTearDown(() => directory.delete(recursive: true));
    final recorder = ui.PictureRecorder();
    ui.Canvas(recorder);
    final picture = recorder.endRecording();
    final image = await picture.toImage(400, 300);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    picture.dispose();
    final original = await File(
      '${directory.path}/photo.jpg',
    ).writeAsBytes(bytes!.buffer.asUint8List());
    final originalSize = await original.length();
    final picked = PickedPhoto(
      path: original.path,
      name: 'photo.jpg',
      size: originalSize,
    );
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async => directory.path);
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null),
    );

    final previous = FlutterImageCompressPlatform.instance;
    final codec = _FakeCodec();
    FlutterImageCompressPlatform.instance = codec;
    addTearDown(() => FlutterImageCompressPlatform.instance = previous);
    final adapter = PhotoCompressorAdapter();

    codec.outputSize = originalSize * 92 ~/ 100;
    expect(
      await adapter.estimateCompressedSize([
        picked,
      ], const CompressionSettings()),
      originalSize,
    );
    final staleSize = PickedPhoto(
      path: original.path,
      name: 'photo.jpg',
      size: originalSize * 2,
    );
    expect(
      await adapter.estimateCompressedSize([
        staleSize,
      ], const CompressionSettings()),
      staleSize.size,
    );
    codec.outputSize = originalSize * 80 ~/ 100;
    expect(
      await adapter.estimateCompressedSize([
        picked,
      ], const CompressionSettings()),
      codec.outputSize,
    );
    final png = await File(
      '${directory.path}/photo.png',
    ).writeAsBytes(bytes.buffer.asUint8List());
    codec.outputSize = originalSize * 92 ~/ 100;
    expect(
      await adapter.estimateCompressedSize([
        PickedPhoto(path: png.path, name: 'photo.png', size: originalSize),
      ], const CompressionSettings(quality: 60)),
      originalSize,
    );
    codec.outputSize = originalSize * 80 ~/ 100;
    final heic = await File(
      '${directory.path}/photo.heic',
    ).writeAsBytes(bytes.buffer.asUint8List());
    final result = await adapter.compress(
      heic.path,
      'photo.heic',
      const CompressionSettings(maxDimension: 256),
    );
    expect(result.success, isTrue);
    expect(result.outputPath, endsWith('.heic'));
    addTearDown(() async {
      if (result.outputPath case final outputPath?) {
        await File(outputPath).delete();
      }
    });
    expect(codec.qualities, [82, 82, 82, 60, 82]);
    expect(codec.formats, [
      CompressFormat.jpeg,
      CompressFormat.jpeg,
      CompressFormat.jpeg,
      CompressFormat.png,
      CompressFormat.heic,
    ]);
    expect(codec.widths, [100000, 100000, 100000, 100000, 256]);
    expect(codec.heights, [100000, 100000, 100000, 100000, 192]);
    expect(
      directory.listSync().whereType<Directory>().map((item) => item.path),
      [endsWith('minimo_photo')],
    );
  });
}

class _FakeCodec extends UnsupportedFlutterImageCompress {
  int outputSize = 0;
  bool throwAfterWrite = false;
  bool nullOutput = false;
  String? returnedPath;
  Completer<void>? gate;
  final started = Completer<void>();
  final qualities = <int>[];
  final formats = <CompressFormat>[];
  final widths = <int>[];
  final heights = <int>[];

  @override
  Future<XFile?> compressAndGetFile(
    String path,
    String targetPath, {
    int minWidth = 1920,
    int minHeight = 1080,
    int inSampleSize = 1,
    int quality = 95,
    int rotate = 0,
    bool autoCorrectionAngle = true,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
    int numberOfRetries = 5,
  }) async {
    qualities.add(quality);
    formats.add(format);
    widths.add(minWidth);
    heights.add(minHeight);
    await File(targetPath).writeAsBytes(List.filled(outputSize, 2));
    if (!started.isCompleted) started.complete();
    await gate?.future;
    if (throwAfterWrite) throw StateError('encoder failed after writing');
    if (nullOutput) return null;
    return XFile(returnedPath ?? targetPath);
  }
}
