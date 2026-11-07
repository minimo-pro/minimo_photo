import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/review_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('rating shown today does not block an eligible video prompt', () async {
    SharedPreferences.setMockInitialValues({
      'review_successful_conversions': 8,
      'video_app_successful_conversions': 3,
      'review_last_request_date': '2026-11-06T08:47:02.488623',
    });
    final service = ReviewService(
      isAvailable: () async => true,
      requestReview: () async {},
      now: () => DateTime(2026, 11, 6, 9),
    );

    expect(
      await service.onSuccessfulConversions(1),
      CompressionPrompt.videoApp,
    );
  });

  test('tracks rating and video prompts with independent cooldowns', () async {
    SharedPreferences.setMockInitialValues({});
    var requests = 0;
    var now = DateTime(2026);
    final service = ReviewService(
      isAvailable: () async => true,
      requestReview: () async => requests++,
      now: () => now,
    );

    expect(await service.onSuccessfulConversions(1), CompressionPrompt.none);
    expect(requests, 0);

    expect(await service.onSuccessfulConversions(1), CompressionPrompt.review);
    expect(requests, 1);
    var prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('review_successful_conversions'), 0);
    expect(prefs.getInt('video_app_successful_conversions'), 2);

    now = DateTime(2026, 2);
    expect(
      await service.onSuccessfulConversions(1),
      CompressionPrompt.videoApp,
    );
    expect(requests, 1);
    prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('review_successful_conversions'), 1);
    expect(prefs.getInt('video_app_successful_conversions'), 0);

    now = DateTime(2026, 4, 1);
    expect(await service.onSuccessfulConversions(1), CompressionPrompt.review);
    expect(requests, 2);
    prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('review_successful_conversions'), 0);
    expect(prefs.getInt('video_app_successful_conversions'), 1);

    now = DateTime(2026, 5);
    expect(await service.onSuccessfulConversions(2), CompressionPrompt.none);
    expect(requests, 2);

    now = DateTime(2026, 5, 5);
    expect(
      await service.onSuccessfulConversions(1),
      CompressionPrompt.videoApp,
    );
    expect(requests, 2);
  });

  test('video prompt can repeat without a newer rating', () async {
    SharedPreferences.setMockInitialValues({
      'video_app_successful_conversions': 2,
      'review_last_request_date': '2026-01-01T00:00:00',
      'video_app_last_prompt_date': '2026-02-01T00:00:00',
    });
    final service = ReviewService(
      isAvailable: () async => false,
      now: () => DateTime(2026, 5, 5),
    );

    expect(
      await service.onSuccessfulConversions(1),
      CompressionPrompt.videoApp,
    );
  });

  test('first video prompt still waits for a rating', () async {
    SharedPreferences.setMockInitialValues({
      'video_app_successful_conversions': 2,
    });
    final service = ReviewService(isAvailable: () async => false);

    expect(await service.onSuccessfulConversions(1), CompressionPrompt.none);
  });
}
