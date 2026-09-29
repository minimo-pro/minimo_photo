import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    return XFile(targetPath);
  }
}
