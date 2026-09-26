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
    final second = await File('${compressed.path}/second.png').writeAsBytes([3]);

    expect(await AppCacheService.size(root: root), 3);
    await AppCacheService.clear(root: root);
    expect(await first.exists(), isFalse);
    expect(await second.exists(), isFalse);
  });
}
