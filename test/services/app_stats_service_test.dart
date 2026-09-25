import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/app_stats_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'stores compressed photo count and non-negative saved bytes locally',
    () async {
      SharedPreferences.setMockInitialValues({});

      await AppStatsService.recordCompressions(photoCount: 1, savedBytes: 60);
      await AppStatsService.recordCompressions(photoCount: 2, savedBytes: -25);

      final stats = await AppStatsService.load();
      expect(stats.compressedPhotos, 3);
      expect(stats.savedBytes, 60);
    },
  );
}
