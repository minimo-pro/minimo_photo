import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../services/app_settings_service.dart';
import '../domain/compression_result.dart';
import '../domain/compression_settings.dart';

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

    final output = await FlutterImageCompress.compressAndGetFile(
      inputPath,
      outputPath,
      quality: settings.quality,
      minWidth: settings.maxDimension ?? 100000,
      minHeight: settings.maxDimension ?? 100000,
      format: png ? CompressFormat.png : CompressFormat.jpeg,
      keepExif: settings.keepExif,
      autoCorrectionAngle: true,
    );
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
    Iterable<String> inputPaths,
    CompressionSettings settings,
  ) async {
    var total = 0;
    for (final inputPath in inputPaths) {
      total += await File(inputPath).length();
    }
    // ponytail: heuristic only; replace if the native package adds estimates.
    return (total * settings.estimateRatio).round();
  }

  Future<String?> createThumbnail(String inputPath) async => inputPath;

  static bool isUsefulCompression(int originalSize, int outputSize) {
    return originalSize > 0 && outputSize * 10 <= originalSize * 9;
  }

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
