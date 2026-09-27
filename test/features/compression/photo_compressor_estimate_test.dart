import 'dart:io';

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
    final original = await File(
      '${directory.path}/photo.jpg',
    ).writeAsBytes(List.filled(1000, 1));
    final picked = PickedPhoto(
      path: original.path,
      name: 'photo.jpg',
      size: 1000,
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

    codec.outputSize = 920;
    expect(
      await adapter.estimateCompressedSize([
        picked,
      ], const CompressionSettings()),
      1000,
    );
    codec.outputSize = 800;
    expect(
      await adapter.estimateCompressedSize([
        picked,
      ], const CompressionSettings()),
      800,
    );
    final png = await File(
      '${directory.path}/photo.png',
    ).writeAsBytes(List.filled(1000, 1));
    codec.outputSize = 920;
    expect(
      await adapter.estimateCompressedSize([
        PickedPhoto(path: png.path, name: 'photo.png', size: 1000),
      ], const CompressionSettings(quality: 60)),
      1000,
    );
    expect(codec.qualities, [82, 82, 60]);
    expect(codec.formats, [
      CompressFormat.jpeg,
      CompressFormat.jpeg,
      CompressFormat.png,
    ]);
    expect(directory.listSync().whereType<Directory>(), isEmpty);
  });
}

class _FakeCodec extends UnsupportedFlutterImageCompress {
  int outputSize = 0;
  final qualities = <int>[];
  final formats = <CompressFormat>[];

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
    await File(targetPath).writeAsBytes(List.filled(outputSize, 2));
    return XFile(targetPath);
  }
}
