import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AppCacheService {
  static const _directoryNames = ['picked_photos', 'minimo_photo'];

  static Future<int> size({Directory? root}) async {
    final directories = await _directories(root);
    var bytes = 0;
    for (final directory in directories) {
      if (!await directory.exists()) continue;
      await for (final entity in directory.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is File) bytes += await entity.length();
      }
    }
    for (final file in await _legacyImports(root)) {
      bytes += await file.length();
    }
    return bytes;
  }

  static Future<void> clear({Directory? root}) async {
    if (BatchCache._active.isNotEmpty) {
      throw StateError('Cannot clear cache while a batch is active');
    }
    for (final directory in await _directories(root)) {
      if (await directory.exists()) await directory.delete(recursive: true);
    }
    for (final file in await _legacyImports(root)) {
      await file.delete();
    }
  }

  static Future<List<File>> _legacyImports(Directory? root) async {
    final directory = root ?? await getTemporaryDirectory();
    final pattern = RegExp(
      r'^photo_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}_',
    );
    return directory
        .list(followLinks: false)
        .where(
          (entry) =>
              entry is File && pattern.hasMatch(path.basename(entry.path)),
        )
        .cast<File>()
        .toList();
  }

  static Future<List<Directory>> _directories(Directory? root) async {
    final temporaryDirectory = root ?? await getTemporaryDirectory();
    final estimates = await temporaryDirectory
        .list(followLinks: false)
        .where(
          (entry) =>
              entry is Directory &&
              path.basename(entry.path).startsWith('minimo_estimate_'),
        )
        .cast<Directory>()
        .toList();
    return [
      ...estimates,
      ..._directoryNames.map(
        (name) => Directory('${temporaryDirectory.path}/$name'),
      ),
    ];
  }
}

/// Tracks only explicitly handed-off cache files, never source/gallery paths.
class BatchCache {
  final Directory? root;
  final _files = <String, FileStat>{};
  static final _active = <BatchCache>{};
  static final _owners = <String, Set<BatchCache>>{};

  BatchCache({this.root}) {
    _active.add(this);
  }

  Future<void> retain(Iterable<String> paths) async {
    paths = paths.where((value) => File(value).existsSync()).toList();
    if (paths.isEmpty) return;
    final cacheRoot = root ?? await getTemporaryDirectory();
    final canonicalRoot = await cacheRoot.resolveSymbolicLinks();
    for (final value in paths) {
      final file = File(value);
      if (await FileSystemEntity.type(value, followLinks: false) !=
          FileSystemEntityType.file) {
        continue;
      }
      final canonical = await file.resolveSymbolicLinks();
      if (!AppCacheService._directoryNames.any(
        (name) => path.isWithin(path.join(canonicalRoot, name), canonical),
      )) {
        continue;
      }
      _files.putIfAbsent(canonical, () => file.statSync());
      (_owners[canonical] ??= {}).add(this);
    }
  }

  Future<void> clear({
    Set<String> keep = const {},
    bool release = false,
  }) async {
    try {
      final canonicalKeep = <String>{};
      for (final value in keep) {
        if (await File(value).exists()) {
          canonicalKeep.add(await File(value).resolveSymbolicLinks());
        }
      }
      for (final value in _files.keys.toList()) {
        if (canonicalKeep.contains(value)) continue;
        final original = _files.remove(value)!;
        final owners = _owners[value]!;
        owners.remove(this);
        if (owners.isNotEmpty) continue;
        _owners.remove(value);
        final file = File(value);
        if (await FileSystemEntity.type(value, followLinks: false) !=
            FileSystemEntityType.file) {
          continue;
        }
        if (await file.resolveSymbolicLinks() != value) continue;
        final current = await file.stat();
        // A reused pathname belongs to its new writer, not this batch.
        if (current.changed != original.changed ||
            current.modified != original.modified ||
            current.size != original.size) {
          continue;
        }
        await file.delete();
        final parent = file.parent;
        if ((path.basename(parent.path).startsWith('operation_') ||
                path.basename(parent.path).startsWith('recovered_')) &&
            await parent.list(followLinks: false).isEmpty) {
          await parent.delete();
        }
      }
    } finally {
      if (release) _active.remove(this);
    }
  }
}
