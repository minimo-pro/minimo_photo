import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
    if (Platform.isIOS) {
      final result = await _channel.invokeMethod<List<dynamic>>('pickPhotos', {
        'source': source.channelValue,
      });
      return mapPlatformFiles(result ?? const []);
    }
    final paths = source == PhotoPickSource.gallery
        ? await _pickGallery()
        : await _pickFiles();
    return _toPickedPhotos(paths, onProgress);
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

  Future<List<String>> _pickGallery() async {
    final files = await _imagePicker.pickMultiImage(limit: 50);
    return files.map((file) => file.path).toList();
  }

  Future<List<String>> _pickFiles() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp', 'heic', 'heif'],
    );
    return files.map((file) => file.path).whereType<String>().toList();
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
