import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../services/app_settings_service.dart';
import '../domain/compression_result.dart';
import '../domain/compression_settings.dart';
import '../domain/picked_photo.dart';

class PhotoCompressorAdapter {
  var _cancelGeneration = 0;

  Future<CompressionResult> compress(
    String inputPath,
    String originalName,
    CompressionSettings settings, {
    bool addMinimoPrefix = true,
    void Function(double progress)? onProgress,
  }) async {
    final generation = _cancelGeneration;
    final stopwatch = Stopwatch()..start();
    final input = File(inputPath);
    final originalSize = await input.length();
    final png = path.extension(originalName).toLowerCase() == '.png';
    final outputPath = await _createOutputPath(
      originalName,
      png: png,
      addMinimoPrefix: addMinimoPrefix,
    );
    onProgress?.call(0);

    final output = await _encode(inputPath, outputPath, png, settings);
    if (output == null) throw StateError('Photo compression failed');

    final outputFile = File(output.path);
    if (generation != _cancelGeneration) {
      if (await outputFile.exists()) await outputFile.delete();
      throw StateError('Photo compression cancelled');
    }
    if (!await outputFile.exists()) {
      throw StateError('Photo compression produced no file');
    }

    onProgress?.call(1);
    final outputSize = await outputFile.length();
    final success = isUsefulCompression(originalSize, outputSize);
    if (!success) await outputFile.delete();
    return CompressionResult(
      success: success,
      originalSize: originalSize,
      outputSize: outputSize,
      outputPath: success ? outputFile.path : null,
      durationMs: stopwatch.elapsedMilliseconds,
    );
  }

  Future<void> cancelCompression() async => _cancelGeneration++;

  Future<int?> estimateCompressedSize(
    Iterable<PickedPhoto> photos,
    CompressionSettings settings, {
    bool Function()? isCancelled,
  }) async {
    var total = 0;
    for (final photo in photos) {
      if (isCancelled?.call() == true) return null;
      final png = path.extension(photo.name).toLowerCase() == '.png';
      final directory = await (await getTemporaryDirectory()).createTemp(
        'minimo_estimate_',
      );
      final outputPath = path.join(
        directory.path,
        png ? 'photo.png' : 'photo.jpg',
      );
      try {
        final output = await _encode(photo.path, outputPath, png, settings);
        if (isCancelled?.call() == true) return null;
        if (output == null) return null;
        final originalSize = await File(photo.path).length();
        final outputSize = await File(output.path).length();
        total += isUsefulCompression(originalSize, outputSize)
            ? outputSize
            : originalSize;
      } catch (_) {
        return null;
      } finally {
        await directory.delete(recursive: true);
      }
    }
    return total;
  }

  Future<String?> createThumbnail(String inputPath) async => inputPath;

  static bool isUsefulCompression(int originalSize, int outputSize) {
    return originalSize > 0 && outputSize * 10 <= originalSize * 9;
  }

  Future<XFile?> _encode(
    String inputPath,
    String outputPath,
    bool png,
    CompressionSettings settings,
  ) => FlutterImageCompress.compressAndGetFile(
    inputPath,
    outputPath,
    quality: settings.quality,
    minWidth: settings.maxDimension ?? 100000,
    minHeight: settings.maxDimension ?? 100000,
    format: png ? CompressFormat.png : CompressFormat.jpeg,
    keepExif: settings.keepExif,
    autoCorrectionAngle: true,
  );

  Future<String> _createOutputPath(
    String originalName, {
    required bool png,
    required bool addMinimoPrefix,
  }) async {
    final temporaryDirectory = await getTemporaryDirectory();
    final outputDirectory = Directory(
      path.join(temporaryDirectory.path, 'minimo_photo'),
    );
    await outputDirectory.create(recursive: true);

    final appPrefix = AppSettingsService.appPrefix;
    final rawBaseName = path.basenameWithoutExtension(originalName);
    final originalBaseName =
        addMinimoPrefix && rawBaseName.startsWith(appPrefix)
        ? rawBaseName.substring(appPrefix.length)
        : rawBaseName;
    final safeBaseName = originalBaseName
        .replaceAll(RegExp(r'[<>:"/\\|?*\x00-\x1F]'), '_')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    final baseName = safeBaseName.isEmpty ? 'photo' : safeBaseName;
    final prefix = addMinimoPrefix ? appPrefix : '';
    final extension = png ? 'png' : 'jpg';
    var candidate = path.join(
      outputDirectory.path,
      '$prefix$baseName.$extension',
    );
    var duplicateIndex = 2;
    while (await FileSystemEntity.type(candidate) !=
        FileSystemEntityType.notFound) {
      candidate = path.join(
        outputDirectory.path,
        '$prefix${baseName}_$duplicateIndex.$extension',
      );
      duplicateIndex++;
    }
    return candidate;
  }
}
