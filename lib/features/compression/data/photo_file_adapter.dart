import 'package:file_picker/file_picker.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/photo_pick_source.dart';
import '../domain/picked_photo.dart';

class PhotoFileAdapter {
  final ImagePicker _imagePicker;

  PhotoFileAdapter({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  Future<List<PickedPhoto>> pickPhotos({
    PhotoPickSource source = PhotoPickSource.gallery,
    void Function(int processed, int total)? onProgress,
  }) async {
    final paths = source == PhotoPickSource.gallery
        ? await _pickGallery()
        : await _pickFiles();
    return _toPickedPhotos(paths, onProgress);
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
}
