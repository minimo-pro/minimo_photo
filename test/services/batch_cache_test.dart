import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/app_cache_service.dart';

void main() {
  late Directory root;
  late BatchCache batch;
  late BatchCache other;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('batch_files_');
    await Directory('${root.path}/picked_photos').create();
    await Directory('${root.path}/minimo_photo').create();
    batch = BatchCache(root: root);
    other = BatchCache(root: root);
  });
  tearDown(() async {
    await batch.clear(release: true);
    await other.clear(release: true);
    await root.delete(recursive: true);
  });
  test(
    'deletes only registered cache files; protects originals and other batches',
    () async {
      final own = await File(
        '${root.path}/minimo_photo/own.jpg',
      ).writeAsBytes([1]);
      final source = await File('${root.path}/original.jpg').writeAsBytes([2]);
      final foreign = await File(
        '${root.path}/minimo_photo/foreign.jpg',
      ).writeAsBytes([3]);
      await batch.retain([own.path, source.path]);
      await other.retain([foreign.path]);
      await batch.clear();
      expect(await own.exists(), isFalse);
      expect(await source.exists(), isTrue);
      expect(await foreign.exists(), isTrue);
    },
  );
  test('reused pathname survives stale cleanup', () async {
    final file = await File(
      '${root.path}/minimo_photo/reused.jpg',
    ).writeAsBytes([1]);
    await batch.retain([file.path]);
    await file.delete();
    await file.writeAsBytes([2, 3]);
    await batch.clear();
    expect(await file.readAsBytes(), [2, 3]);
  });
  test('shared cache source remains until last batch releases it', () async {
    final file = await File(
      '${root.path}/picked_photos/shared.jpg',
    ).writeAsBytes([1]);
    await batch.retain([file.path]);
    await other.retain([file.path]);
    await batch.clear();
    expect(await file.exists(), isTrue);
    await other.clear();
    expect(await file.exists(), isFalse);
  });
  test('rejects file and directory symlinks outside owned cache', () async {
    final original = await File('${root.path}/original.jpg').writeAsBytes([1]);
    final link = await Link(
      '${root.path}/minimo_photo/link.jpg',
    ).create(original.path);
    await Link('${root.path}/picked_photos/escape').create(root.path);
    await batch.retain([
      link.path,
      '${root.path}/picked_photos/escape/original.jpg',
    ]);
    await batch.clear();
    expect(await original.exists(), isTrue);
    expect(await link.exists(), isTrue);
  });
  test(
    'cold/manual cleanup removes abandoned cache but keeps originals',
    () async {
      await batch.clear(release: true);
      await other.clear(release: true);
      final original = await File(
        '${root.path}/original.jpg',
      ).writeAsBytes([1]);
      final partial = await File(
        '${root.path}/minimo_photo/partial.jpg',
      ).writeAsBytes([2]);
      await AppCacheService.clear(root: root);
      expect(await partial.exists(), isFalse);
      expect(await original.exists(), isTrue);
    },
  );
}
