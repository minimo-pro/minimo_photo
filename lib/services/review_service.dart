import 'package:flutter/services.dart';
import 'package:rate_my_app/rate_my_app.dart';

enum CompressionPrompt { none, review, videoApp, githubStar }

class ReviewService {
  static const _successfulConversionsKey = 'review_successful_conversions';
  static const _videoConversionsKey = 'video_app_successful_conversions';
  static const _lastReviewRequestDateKey = 'review_last_request_date';
  static const _lastVideoPromptDateKey = 'video_app_last_prompt_date';
  static const _successfulConversionsToShowReview = 2;
  static const _successfulConversionsToShowVideoApp = 3;
  static const _monthsBetweenReviews = 3;

  static const _githubRunsKey = 'github_star_successful_runs';
  static const _githubShownKey = 'github_star_prompt_shown';
  static const _runsToShowGithub = 7;

  static final instance = ReviewService();
  static final _rateMyApp = RateMyApp(
    appStoreIdentifier: '6822256099',
    googlePlayIdentifier: 'com.khlebobul.minimo_photo',
  );

  final Future<bool> Function() _isAvailable;
  final Future<void> Function() _requestReview;
  final DateTime Function() _now;

  ReviewService({
    Future<bool> Function()? isAvailable,
    Future<void> Function()? requestReview,
    DateTime Function()? now,
  }) : _isAvailable =
           isAvailable ??
           (() => _rateMyApp.isNativeReviewDialogSupported.then(
             (supported) => supported ?? false,
             onError: (_) => false,
           )),
       _requestReview =
           requestReview ??
           (() async {
             // The package's Future<void> adapter discards native false results.
             final result = await const MethodChannel('rate_my_app')
                 .invokeMethod<bool>('launchNativeReviewDialog');
             if (result == false) {
               throw StateError('Native review request failed');
             }
           }),
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
    final githubShown = prefs.getBool(_githubShownKey) ?? false;
    final runs = (prefs.getInt(_githubRunsKey) ?? 0) + 1;
    if (!githubShown && runs <= _runsToShowGithub) {
      await prefs.setInt(_githubRunsKey, runs);
    }
    final prompt = await _showPromptIfAllowed(prefs);
    if (prompt == CompressionPrompt.none &&
        !githubShown &&
        runs >= _runsToShowGithub) {
      return CompressionPrompt.githubStar;
    }
    return prompt;
  }

  Future<void> markGithubPromptShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_githubShownKey, true);
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
