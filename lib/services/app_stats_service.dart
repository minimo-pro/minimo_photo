import 'package:shared_preferences/shared_preferences.dart';

class AppStats {
  final int compressedPhotos;
  final int savedBytes;

  const AppStats({required this.compressedPhotos, required this.savedBytes});
}

abstract final class AppStatsService {
  static const _compressedPhotosKey = 'stats_compressed_photos';
  static const _savedBytesKey = 'stats_saved_bytes';

  static Future<AppStats> load() async {
    final preferences = await SharedPreferences.getInstance();
    return AppStats(
      compressedPhotos: preferences.getInt(_compressedPhotosKey) ?? 0,
      savedBytes: preferences.getInt(_savedBytesKey) ?? 0,
    );
  }

  static Future<void> recordCompressions({
    required int photoCount,
    required int savedBytes,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.wait([
      preferences.setInt(
        _compressedPhotosKey,
        (preferences.getInt(_compressedPhotosKey) ?? 0) + photoCount,
      ),
      preferences.setInt(
        _savedBytesKey,
        (preferences.getInt(_savedBytesKey) ?? 0) +
            (savedBytes < 0 ? 0 : savedBytes),
      ),
    ]);
  }
}
