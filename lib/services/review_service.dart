import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CompressionPrompt { none, review, videoApp }

class ReviewService {
  static const _successfulConversionsKey = 'review_successful_conversions';
  static const _videoConversionsKey = 'video_app_successful_conversions';
  static const _lastReviewRequestDateKey = 'review_last_request_date';
  static const _lastVideoPromptDateKey = 'video_app_last_prompt_date';
  static const _successfulConversionsToShowReview = 2;
  static const _successfulConversionsToShowVideoApp = 3;
  static const _monthsBetweenReviews = 3;

  static final instance = ReviewService();

  final Future<bool> Function() _isAvailable;
  final Future<void> Function() _requestReview;
  final DateTime Function() _now;

  ReviewService({
    Future<bool> Function()? isAvailable,
    Future<void> Function()? requestReview,
    DateTime Function()? now,
  }) : _isAvailable = isAvailable ?? InAppReview.instance.isAvailable,
       _requestReview = requestReview ?? InAppReview.instance.requestReview,
       _now = now ?? DateTime.now;

  Future<CompressionPrompt> onSuccessfulConversions(int count) async {
    if (count <= 0) return CompressionPrompt.none;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      _successfulConversionsKey,
      (prefs.getInt(_successfulConversionsKey) ?? 0) + count,
    );
    await prefs.setInt(
      _videoConversionsKey,
      (prefs.getInt(_videoConversionsKey) ?? 0) + count,
    );
    return _showPromptIfAllowed(prefs);
  }

  Future<CompressionPrompt> _showPromptIfAllowed(
    SharedPreferences prefs,
  ) async {
    final lastReview = DateTime.tryParse(
      prefs.getString(_lastReviewRequestDateKey) ?? '',
    );
    final lastVideo = DateTime.tryParse(
      prefs.getString(_lastVideoPromptDateKey) ?? '',
    );
    if (lastReview != null &&
        (lastVideo == null || lastReview.isAfter(lastVideo)) &&
        (prefs.getInt(_videoConversionsKey) ?? 0) >=
            _successfulConversionsToShowVideoApp &&
        (lastVideo == null ||
            _now().difference(lastVideo).inDays ~/ 30 >=
                _monthsBetweenReviews)) {
      await prefs.setString(_lastVideoPromptDateKey, _now().toIso8601String());
      await prefs.setInt(_videoConversionsKey, 0);
      return CompressionPrompt.videoApp;
    }

    if ((prefs.getInt(_successfulConversionsKey) ?? 0) <
            _successfulConversionsToShowReview ||
        (lastReview != null &&
            _now().difference(lastReview).inDays ~/ 30 <
                _monthsBetweenReviews)) {
      return CompressionPrompt.none;
    }
    if (!await _isAvailable()) return CompressionPrompt.none;

    try {
      await _requestReview();
      await prefs.setString(
        _lastReviewRequestDateKey,
        _now().toIso8601String(),
      );
      await prefs.setInt(_successfulConversionsKey, 0);
      return CompressionPrompt.review;
    } catch (_) {
      return CompressionPrompt.none;
    }
  }
}
