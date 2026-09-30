import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/photo_pick_source.dart';
import '../domain/picked_photo.dart';

class PhotoFileAdapter {
  static const _channel = MethodChannel('minimo_photo/photos');
  final ImagePicker _imagePicker;

  PhotoFileAdapter({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  Future<List<PickedPhoto>> pickPhotos({
    PhotoPickSource source = PhotoPickSource.gallery,
    void Function(int processed, int total)? onProgress,
  }) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method != 'pickProgress') return;
      final progress = call.arguments as Map<dynamic, dynamic>;
      onProgress?.call(progress['processed'] as int, progress['total'] as int);
    });
    final List<dynamic>? result;
    try {
      result = await _channel.invokeMethod<List<dynamic>>('pickPhotos', {
        'source': source.channelValue,
      });
    } finally {
      _channel.setMethodCallHandler(null);
    }
    return mapPlatformFiles(result ?? const []);
  }

  Future<void> cancelPhotoPick() async {
    try {
      await _channel.invokeMethod<void>('cancelPhotoPick');
    } on PlatformException {
      // Leaving the screen should still succeed if the picker already closed.
    } on MissingPluginException {
      // Unsupported platforms may not provide the native picker.
    }
  }

  static List<PickedPhoto> mapPlatformFiles(List<dynamic> result) {
    return result.cast<Map<dynamic, dynamic>>().map((file) {
      return PickedPhoto(
        path: file['path'] as String,
        name: file['name'] as String,
        size: file['size'] as int,
        sourceIdentifier: file['sourceIdentifier'] as String?,
        canPreserveMetadata: file['canPreserveMetadata'] as bool? ?? false,
        canDeleteOriginal: file['canDeleteOriginal'] as bool? ?? false,
        captureDate: file['captureDate'] as String?,
        latitude: (file['latitude'] as num?)?.toDouble(),
        longitude: (file['longitude'] as num?)?.toDouble(),
      );
    }).toList();
  }

  Future<List<PickedPhoto>> recoverLostPhotos() async {
    final response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) return const [];
    if (response.exception case final exception?) throw exception;
    return _toPickedPhotos(
      response.files?.map((file) => file.path).toList() ?? const [],
      null,
    );
  }

  Future<List<PickedPhoto>> _toPickedPhotos(
    List<String> paths,
    void Function(int processed, int total)? onProgress,
  ) async {
    final photos = <PickedPhoto>[];
    for (var index = 0; index < paths.length; index++) {
      final file = XFile(paths[index]);
      photos.add(
        PickedPhoto(
          path: file.path,
          name: file.name,
          size: await file.length(),
        ),
      );
      onProgress?.call(index + 1, paths.length);
    }
    return photos;
  }

  Future<void> saveToGallery(String filePath, {String? album}) {
    return Gal.putImage(filePath, album: album);
  }

  Future<GallerySaveResult> saveReplacement(
    String filePath,
    String sourceIdentifier, {
    String? album,
    String? captureDate,
    double? latitude,
    double? longitude,
  }) async {
    final result = await _channel
        .invokeMapMethod<String, dynamic>('saveReplacement', {
          'path': filePath,
          'sourceIdentifier': sourceIdentifier,
          'album': album,
          'captureDate': captureDate,
          'latitude': latitude,
          'longitude': longitude,
        });
    if (result == null || result['saved'] != true) {
      throw StateError('replacement photo was not saved');
    }
    return GallerySaveResult(
      warnings: (result['warnings'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
    );
  }

  Future<int> deleteOriginals(Iterable<String> sourceIdentifiers) async {
    return await _channel.invokeMethod<int>(
          'deleteOriginals',
          sourceIdentifiers.toList(),
        ) ??
        0;
  }
}

class GallerySaveResult {
  final List<String> warnings;

  const GallerySaveResult({this.warnings = const []});
}
