import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/domain/photo_pick_source.dart';
import 'package:minimo_photo/features/compression/presentation/compress_screen.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/services/app_settings_service.dart';
import 'package:minimo_photo/services/screen_awake_service.dart';
import 'package:minimo_photo/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('minimo_photo/photos');

  for (final enabled in [true, false]) {
    testWidgets('screen awake during import: $enabled', (tester) async {
      final settings = AppSettingsService.instance;
      final previousSetting = settings.preventScreenSleep;
      final previousService = ScreenAwakeService.instance;
      final awake = _RecordingScreenAwakeService();
      settings.preventScreenSleep = enabled;
      ScreenAwakeService.instance = awake;
      addTearDown(() {
        settings.preventScreenSleep = previousSetting;
        ScreenAwakeService.instance = previousService;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null);
      });

      final picked = Completer<List<dynamic>>();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) {
            if (call.method == 'pickPhotos') return picked.future;
            return null;
          });

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: '/compress',
          routes: {
            '/': (_) => const Scaffold(body: Text('start')),
            '/compress': (_) => const CompressScreen(
              initialPickSource: PhotoPickSource.gallery,
            ),
          },
        ),
      );
      await tester.pump();
      expect(awake.calls, enabled ? [true] : isEmpty);

      picked.complete([]);
      await tester.pumpAndSettle();
      expect(awake.calls, enabled ? [true, false] : isEmpty);
    });
  }
}

class _RecordingScreenAwakeService extends ScreenAwakeService {
  final calls = <bool>[];

  @override
  Future<void> setEnabled(bool enabled) async => calls.add(enabled);
}
