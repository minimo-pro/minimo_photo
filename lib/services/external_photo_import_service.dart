import 'package:flutter/services.dart';

import '../features/compression/data/photo_file_adapter.dart';
import '../features/compression/domain/picked_photo.dart';
import '../features/compression/domain/compression_settings.dart';

class ExternalPhotoImport {
  final List<PickedPhoto> photos;
  final CompressionSettings settings;

  const ExternalPhotoImport({required this.photos, required this.settings});
}

class ExternalPhotoImportService {
  static const _channel = MethodChannel('minimo_photo/external_photos');

  void listen(Future<void> Function() onAvailable) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'externalPhotosAvailable') await onAvailable();
    });
  }

  void stopListening() => _channel.setMethodCallHandler(null);

  Future<ExternalPhotoImport?> consume() async {
    try {
      final payload = await _channel.invokeMapMethod<String, dynamic>(
        'consumeExternalPhotos',
      );
      final files = payload?['files'] as List<dynamic>? ?? const [];
      if (files.isEmpty) return null;
      final preset = switch (payload?['preset']) {
        'high' => SimpleCompressionQuality.high,
        'low' => SimpleCompressionQuality.low,
        _ => SimpleCompressionQuality.medium,
      };
      return ExternalPhotoImport(
        photos: PhotoFileAdapter.mapPlatformFiles(files),
        settings: CompressionSettings.forSimpleQuality(preset),
      );
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }
}
