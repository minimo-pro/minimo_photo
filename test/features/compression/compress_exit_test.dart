import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/compress_screen.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_settings_view.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final saved in [false, true]) {
    testWidgets('exit confirmation for results: saved=$saved', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final root = (await tester.runAsync(
        () => Directory.systemTemp.createTemp('exit_widget_'),
      ))!;
      const channel = MethodChannel('plugins.flutter.io/path_provider');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async => root.path);
      addTearDown(() async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null);
        await root.delete(recursive: true);
      });
      final photo = PickedPhoto(
        path: File('assets/logo/logo.png').absolute.path,
        name: 'photo.jpg',
        size: 100,
      );
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
            '/compress': (_) => CompressScreen(initialPhotos: [photo]),
          },
        ),
      );
      for (var i = 0; i < 10; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump();
      }
      final bloc = tester
          .element(find.byType(CompressionSettingsView))
          .read<CompressBloc>();
      bloc.emit(
        bloc.state.copyWith(
          status: CompressStatus.done,
          isEstimating: false,
          isSaved: saved,
          photoStatuses: [PhotoCompressionStatus.compressed],
          results: [
            CompressedPhoto(
              source: photo,
              result: CompressionResult(
                success: true,
                outputPath: '/missing-output.jpg',
                originalSize: 100,
                outputSize: 50,
              ),
            ),
          ],
        ),
      );
      await tester.pump();
      final context = tester.element(find.byType(CompressScreen));
      await Navigator.of(context).maybePop();
      await tester.pump();
      if (!saved) {
        expect(find.text('unsaved photos'), findsOneWidget);
        await tester.tap(find.text('cancel'));
        await tester.pumpAndSettle();
        expect(find.byType(CompressScreen), findsOneWidget);
        expect(bloc.isClosed, isFalse);
        await Navigator.of(context).maybePop();
        await tester.pumpAndSettle();
        await tester.tap(find.text('Close'));
      } else {
        expect(find.text('unsaved photos'), findsNothing);
      }
      for (var i = 0; i < 10; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump();
      }
      await tester.pumpAndSettle();
      expect(find.text('start'), findsOneWidget);
      expect(find.byType(CompressScreen), findsNothing);
    });
  }
}
