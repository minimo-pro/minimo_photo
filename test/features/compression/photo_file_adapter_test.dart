import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimo_photo/services/app_cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/data/photo_file_adapter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final cached in [false, true]) {
    test('recovered import owns only its cache copy: cached=$cached', () async {
      final root = await Directory.systemTemp.createTemp('recovered_import_');
      addTearDown(() => root.delete(recursive: true));
      final sourceDirectory = await Directory(
        '${root.path}/${cached ? '12345678-1234-1234-1234-123456789012' : 'gallery'}',
      ).create();
      final source = await File(
        '${sourceDirectory.path}/photo.jpg',
      ).writeAsBytes([1, 2]);
      const channel = MethodChannel('plugins.flutter.io/path_provider');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async => root.path);
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null),
      );
      final adapter = PhotoFileAdapter(
        imagePicker: _RecoveredPicker(source.path),
      );
      final photos = await adapter.recoverLostPhotos();
      expect(photos.single.path, contains('/picked_photos/recovered_'));
      expect(await File(photos.single.path).readAsBytes(), [1, 2]);
      expect(await source.exists(), !cached);
      final batch = BatchCache(root: root);
      await batch.retain(photos.map((p) => p.path));
      await batch.clear(release: true);
      expect(await File(photos.single.path).exists(), isFalse);
      if (!cached) expect(await source.readAsBytes(), [1, 2]);
    });
  }
  test('maps native photo capabilities and metadata', () {
    final photos = PhotoFileAdapter.mapPlatformFiles([
      {
        'path': '/tmp/photo.jpg',
        'name': 'photo.jpg',
        'size': 42,
        'sourceIdentifier': 'asset-1',
        'canPreserveMetadata': true,
        'canDeleteOriginal': true,
        'captureDate': '2026-09-26T10:00:00Z',
        'latitude': 55.75,
        'longitude': 37.62,
      },
    ]);

    final photo = photos.single;
    expect(photo.sourceIdentifier, 'asset-1');
    expect(photo.canPreserveMetadata, isTrue);
    expect(photo.canDeleteOriginal, isTrue);
    expect(photo.captureDate, '2026-09-26T10:00:00Z');
    expect(photo.latitude, 55.75);
    expect(photo.longitude, 37.62);
  });
}

class _RecoveredPicker extends ImagePicker {
  final String path;
  _RecoveredPicker(this.path);
  @override
  Future<LostDataResponse> retrieveLostData() async =>
      LostDataResponse(files: [XFile(path)]);
}
