import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/screens/stats_screen.dart';
import 'package:minimo_photo/theme/app_theme.dart';
import 'package:minimo_photo/widgets/app_action_button.dart';
import 'package:minimo_photo/widgets/bottom_frame.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const channel = MethodChannel('dev.fluttercommunity.plus/share');

  Future<void> openStats(
    WidgetTester tester,
    String locale,
    int count, {
    Size size = const Size(390, 844),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({
      'stats_compressed_photos': count,
      'stats_saved_bytes': count == 0 ? 0 : 128 * 1024 * 1024,
    });
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: Locale(locale),
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const Scaffold(body: BottomFrame()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(InkWell).at(1));
    await tester.pumpAndSettle();
  }

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('compact statistics sheet has a full-width accent share button', (
    tester,
  ) async {
    await openStats(tester, 'ru', 42);
    final buttonBottom = tester.getBottomRight(find.byType(AppActionButton)).dy;
    final sheetBottom = tester.getBottomRight(find.byType(StatsScreen)).dy;
    expect(sheetBottom - buttonBottom, greaterThanOrEqualTo(24));
    expect(
      tester.getSize(find.byType(StatsScreen)).height,
      lessThan(844 * 0.43),
    );
    expect(tester.getSize(find.byType(AppActionButton)).width, 390 - 40);
    expect(
      tester.widget<AppActionButton>(find.byType(AppActionButton)).variant,
      AppActionButtonVariant.filled,
    );
    expect(tester.takeException(), isNull);
  });

  for (final supportedLocale in S.delegate.supportedLocales) {
    final locale = supportedLocale.languageCode;
    final messages =
        jsonDecode(File('lib/l10n/intl_$locale.arb').readAsStringSync())
            as Map<String, dynamic>;
    testWidgets('share stays accessible at 320x480: $locale', (tester) async {
      var shared = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
            shared = true;
            return 'dev.fluttercommunity.plus/share/dismissed';
          });
      await openStats(tester, locale, 42, size: const Size(320, 480));
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.byType(AppActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppActionButton));
      await tester.pumpAndSettle();
      expect(shared, isTrue);
      expect(tester.takeException(), isNull);
    });
    for (final count in [0, 42]) {
      testWidgets('shares localized stats: $locale, $count photos', (
        tester,
      ) async {
        final calls = <MethodCall>[];
        final result = Completer<String>();
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (call) {
              calls.add(call);
              return result.future;
            });
        await openStats(tester, locale, count);
        await tester.tap(find.byType(AppActionButton));
        await tester.pump();
        expect(calls.single.method, 'share');
        final args = calls.single.arguments as Map;
        final size = count == 0 ? '0 B' : '128.0 MB';
        expect(
          args['text'],
          (messages['shareStatisticsText'] as String)
              .replaceAll('{count}', '$count')
              .replaceAll('{size}', size),
        );
        expect(args['text'], contains('https://minimo-photo.vercel.app'));
        if (locale != 'en') {
          expect(args['text'], isNot(contains('My results')));
          expect(
            S.current.failedToShareStatistics,
            messages['failedToShareStatistics'],
          );
        }
        expect(args.containsKey('paths'), isFalse);
        expect(args['originWidth'], greaterThan(0));
        expect(args['originHeight'], greaterThan(0));
        expect(
          tester
              .widget<AppActionButton>(find.byType(AppActionButton))
              .onPressed,
          isNull,
        );
        result.complete('dev.fluttercommunity.plus/share/dismissed');
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<AppActionButton>(find.byType(AppActionButton))
              .onPressed,
          isNotNull,
        );
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('shows error and allows retry when sharing fails', (
    tester,
  ) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async {
          throw PlatformException(code: 'share_failed');
        });
    await openStats(tester, 'ru', 42);
    await tester.tap(find.byType(AppActionButton));
    await tester.pumpAndSettle();
    expect(
      find.text('не удалось поделиться статистикой. попробуйте ещё раз'),
      findsOneWidget,
    );
    expect(
      tester.widget<AppActionButton>(find.byType(AppActionButton)).onPressed,
      isNotNull,
    );
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
