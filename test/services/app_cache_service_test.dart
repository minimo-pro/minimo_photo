import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/app_cache_service.dart';

void main() {
  test('counts and clears app cache', () async {
    final root = await Directory.systemTemp.createTemp('minimo_cache_test');
    addTearDown(() => root.delete(recursive: true));
    final picked = await Directory('${root.path}/picked_photos').create();
    final compressed = await Directory('${root.path}/minimo_photo').create();
    final first = await File('${picked.path}/first.jpg').writeAsBytes([1, 2]);
    final second = await File(
      '${compressed.path}/second.png',
    ).writeAsBytes([3]);

    final original = await File('${root.path}/original.jpg').writeAsBytes([4]);
    final legacy = await File(
      '${root.path}/photo_12345678-1234-1234-1234-123456789012_image.jpg',
    ).writeAsBytes([5]);
    final estimate = await Directory(
      '${root.path}/minimo_estimate_abandoned',
    ).create();
    await File('${estimate.path}/photo.jpg').writeAsBytes([6]);
    expect(await AppCacheService.size(root: root), 5);
    await AppCacheService.clear(root: root);
    expect(await first.exists(), isFalse);
    expect(await second.exists(), isFalse);
    expect(await legacy.exists(), isFalse);
    expect(await estimate.exists(), isFalse);
    expect(await original.exists(), isTrue);
  });
}
