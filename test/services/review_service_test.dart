import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/review_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('native review integration', () {
    const channel = MethodChannel('rate_my_app');
    final calls = <String>[];
    bool? supported;
    var failAvailability = false;
    var failRequest = false;
    bool? requestResult;

    setUp(() {
      SharedPreferences.setMockInitialValues({
        'review_successful_conversions': 1,
      });
      calls.clear();
      supported = true;
      failAvailability = false;
      failRequest = false;
      requestResult = null;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            calls.add(call.method);
            if (call.method == 'isNativeDialogSupported') {
              if (failAvailability) {
                throw PlatformException(code: 'unavailable');
              }
              return supported;
            }
            if (call.method == 'launchNativeReviewDialog') {
              if (failRequest) throw PlatformException(code: 'unavailable');
              return requestResult;
            }
            fail('Unexpected method: ${call.method}');
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('uses native dialog and preserves existing preference keys', () async {
      final now = DateTime(2026, 11, 15);
      final service = ReviewService(now: () => now);

      expect(
        await service.onSuccessfulConversions(1),
        CompressionPrompt.review,
      );
      expect(calls, ['isNativeDialogSupported', 'launchNativeReviewDialog']);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('review_successful_conversions'), 0);
      expect(
        prefs.getString('review_last_request_date'),
        now.toIso8601String(),
      );
      expect(
        prefs.getKeys().any((key) => key.startsWith('rateMyApp_')),
        isFalse,
      );
    });

    test('unsupported native dialog keeps progress', () async {
      for (final value in [false, null]) {
        supported = value;
        expect(
          await ReviewService().onSuccessfulConversions(1),
          CompressionPrompt.none,
        );
      }
      expect(calls, ['isNativeDialogSupported', 'isNativeDialogSupported']);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('review_successful_conversions'), 3);
      expect(prefs.containsKey('review_last_request_date'), isFalse);
    });

    test('failed native request keeps progress', () async {
      failRequest = true;
      expect(
        await ReviewService().onSuccessfulConversions(1),
        CompressionPrompt.none,
      );
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('review_successful_conversions'), 2);
      expect(prefs.containsKey('review_last_request_date'), isFalse);
    });

    test(
      'native false response keeps progress without recording a date',
      () async {
        requestResult = false;
        expect(
          await ReviewService().onSuccessfulConversions(1),
          CompressionPrompt.none,
        );
        expect(calls, ['isNativeDialogSupported', 'launchNativeReviewDialog']);
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getInt('review_successful_conversions'), 2);
        expect(prefs.containsKey('review_last_request_date'), isFalse);
      },
    );

    test('availability error keeps progress without requesting', () async {
      failAvailability = true;
      expect(
        await ReviewService().onSuccessfulConversions(1),
        CompressionPrompt.none,
      );
      expect(calls, ['isNativeDialogSupported']);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('review_successful_conversions'), 2);
      expect(prefs.containsKey('review_last_request_date'), isFalse);
    });
  });

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
