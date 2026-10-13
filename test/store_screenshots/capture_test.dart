// Renders real app screens with demo data for the store screenshot editor.
//
//   flutter test test/store_screenshots/capture_test.dart
//
// Output: store_screenshots/public/screenshots/<platform>/<device>/<locale>/*.png
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/constants/app_icons.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_progress_view.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_result_view.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_settings_view.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/theme/app_theme.dart';
import 'package:minimo_photo/widgets/app_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _root = 'store_screenshots/public';
final _photos = [
  'beach',
  'dog',
  'birthday',
  'mountains',
  'concert',
].map((name) => File('$_root/photos/$name.jpg').absolute.path).toList();

enum _Chrome { iphone, android, ipad, duoOuter, duoInner }

class _Device {
  final String folder;
  final Size physicalSize;
  final double pixelRatio;
  final EdgeInsets padding;
  final TargetPlatform platform;
  final _Chrome chrome;

  const _Device({
    required this.folder,
    required this.physicalSize,
    required this.pixelRatio,
    required this.padding,
    required this.platform,
    required this.chrome,
  });
}

const _devices = [
  _Device(
    folder: 'apple/duo-outer',
    physicalSize: Size(1398, 2034),
    pixelRatio: 3,
    padding: EdgeInsets.only(top: 24, bottom: 24, right: 84),
    platform: TargetPlatform.iOS,
    chrome: _Chrome.duoOuter,
  ),
  _Device(
    folder: 'apple/duo-inner',
    physicalSize: Size(2007, 2853),
    pixelRatio: 3,
    padding: EdgeInsets.only(top: 48, bottom: 24),
    platform: TargetPlatform.iOS,
    chrome: _Chrome.duoInner,
  ),
  _Device(
    folder: 'apple/iphone',
    physicalSize: Size(1320, 2868),
    pixelRatio: 3,
    padding: EdgeInsets.only(top: 62, bottom: 34),
    platform: TargetPlatform.iOS,
    chrome: _Chrome.iphone,
  ),
  _Device(
    folder: 'apple/ipad',
    physicalSize: Size(2064, 2752),
    pixelRatio: 2.5,
    padding: EdgeInsets.only(top: 32, bottom: 20),
    platform: TargetPlatform.iOS,
    chrome: _Chrome.ipad,
  ),
  _Device(
    folder: 'android/phone',
    physicalSize: Size(1080, 2416),
    pixelRatio: 2.625,
    padding: EdgeInsets.only(top: 36, bottom: 20),
    platform: TargetPlatform.android,
    chrome: _Chrome.android,
  ),
];

final _items = [
  for (var i = 0; i < _photos.length; i++)
    PickedPhoto(
      path: _photos[i],
      name: '${['beach', 'dog', 'birthday', 'mountains', 'concert'][i]}.jpg',
      size: File(_photos[i]).lengthSync(),
      canPreserveMetadata: true,
    ),
];

CompressState _readyState() => CompressState.initial(_items).copyWith(
  thumbnailPaths: _photos,
  estimatedSize: _items.fold<int>(
    0,
    (n, p) => n + File(p.path.replaceAll('.jpg', '-small.jpg')).lengthSync(),
  ),
  isEstimating: false,
);

CompressedPhoto _compressed(PickedPhoto photo) => CompressedPhoto(
  source: photo,
  result: CompressionResult(
    success: true,
    originalSize: photo.size,
    outputSize: File(photo.path.replaceAll('.jpg', '-small.jpg')).lengthSync(),
    outputPath: photo.path.replaceAll('.jpg', '-small.jpg'),
  ),
);

CompressState _processingState() => _readyState().copyWith(
  status: CompressStatus.processing,
  compressionRunId: 1,
  processingIndex: 2,
  photoStatuses: [
    PhotoCompressionStatus.compressed,
    PhotoCompressionStatus.compressed,
    PhotoCompressionStatus.processing,
    PhotoCompressionStatus.waiting,
    PhotoCompressionStatus.waiting,
  ],
  results: [for (final p in _items.take(2)) _compressed(p)],
  progress: .4,
  currentPhotoProgress: .5,
  elapsed: const Duration(seconds: 2),
);

CompressState _doneState() => _readyState().copyWith(
  status: CompressStatus.done,
  results: [for (final p in _items) _compressed(p)],
  progress: 1,
  photoStatuses: List.filled(_items.length, PhotoCompressionStatus.compressed),
  elapsed: const Duration(seconds: 5),
);

final _captureKey = GlobalKey();
late Locale _locale;

void main() {
  group(
    'store screenshots',
    _captureScreenshots,
    // Skip setup too: CI has neither local photo fixtures nor macOS fonts.
    skip: !Directory('$_root/photos').existsSync(),
  );
}

void _captureScreenshots() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final cacheLimit = imageCache.maximumSizeBytes;
  tearDownAll(() => imageCache.maximumSizeBytes = cacheLimit);
  setUpAll(() async {
    // Keep original/compressed fixture pairs cached across fake-async captures.
    imageCache.maximumSizeBytes = 256 * 1024 * 1024;
    SharedPreferences.setMockInitialValues({});
    await (FontLoader(
      'Pangolin',
    )..addFont(rootBundle.load('assets/fonts/Pangolin-Regular.ttf'))).load();
    await (FontLoader(
      'StatusBar',
    )..addFont(rootBundle.load('assets/fonts/Pangolin-Regular.ttf'))).load();
  });
  setUpAll(() async {
    if (_devices.any((d) => d.folder.contains('duo-'))) {
      await (FontLoader('DuoStatus')..addFont(
            File(
              '/System/Library/Fonts/SFNS.ttf',
            ).readAsBytes().then(ByteData.sublistView),
          ))
          .load();
    }
  });
  for (final locale in S.delegate.supportedLocales) {
    for (final device in _devices) {
      if (device.folder.contains('duo-') && locale.languageCode != 'en') {
        continue;
      }
      testWidgets(
        'capture ${device.folder}/${locale.languageCode}',
        (tester) async {
          _locale = locale;
          tester.view.physicalSize = device.physicalSize;
          tester.view.devicePixelRatio = device.pixelRatio;
          tester.view.padding = FakeViewPadding(
            top: device.padding.top * device.pixelRatio,
            right: device.padding.right * device.pixelRatio,
            bottom: device.padding.bottom * device.pixelRatio,
          );
          tester.view.viewPadding = tester.view.padding;
          debugDefaultTargetPlatformOverride = device.platform;
          addTearDown(() {
            tester.view.reset();
            debugDefaultTargetPlatformOverride = null;
          });
          await _precacheImages(tester);
          await _shoot(
            tester,
            device,
            '01-settings',
            _CompressPage(
              child: CompressionSettingsView(
                state: _readyState(),
                onAddPhotos: () {},
              ),
            ),
          );
          await _shoot(
            tester,
            device,
            '02-advanced',
            _CompressPage(
              child: CompressionSettingsView(
                state: _readyState(),
                onAddPhotos: () {},
              ),
            ),
            interact: () async {
              await tester.tap(find.text(S.current.advancedOptions));
              await _settle(tester);
            },
          );
          await _shoot(
            tester,
            device,
            '03-progress',
            _CompressPage(
              showBack: false,
              child: CompressionProgressView(state: _processingState()),
            ),
          );
          await _shoot(
            tester,
            device,
            '04-result',
            _CompressPage(
              child: CompressionResultView(
                state: _doneState(),
                onTryAgain: () {},
              ),
            ),
          );
          await _shoot(
            tester,
            device,
            '05-compare',
            _CompressPage(
              child: CompressionResultView(
                state: _doneState(),
                onTryAgain: () {},
              ),
            ),
            interact: () async {
              await tester.tap(
                find.byWidgetPredicate(
                  (w) => w is AppActionButton && w.icon == AppIcons.vs,
                ),
              );
              await _settle(tester);
            },
          );
          await _shoot(
            tester,
            device,
            '09-result-dark',
            _CompressPage(
              child: CompressionResultView(
                state: _doneState(),
                onTryAgain: () {},
              ),
            ),
            dark: true,
          );
          debugDefaultTargetPlatformOverride = null;
        },
      );
    }
  }
}

/// Must run before any Image widget starts loading the same provider inside
/// the fake-async zone, otherwise precaching waits on that load forever.
Future<void> _precacheImages(WidgetTester tester) async {
  await tester.pumpWidget(
    const Directionality(textDirection: TextDirection.ltr, child: SizedBox()),
  );
  final context = tester.element(find.byType(SizedBox));
  await tester.runAsync(() async {
    for (final path in [
      ..._photos,
      ..._photos.map((p) => p.replaceAll('.jpg', '-small.jpg')),
    ]) {
      await precacheImage(FileImage(File(path)), context);
    }
    for (final asset in [
      'assets/images/background.png',
      'assets/images/background_dark.png',
    ]) {
      await precacheImage(AssetImage(asset), context);
    }
  });
}

Future<void> _settle(WidgetTester tester, {int seconds = 2}) async {
  for (var i = 0; i < seconds * 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _shoot(
  WidgetTester tester,
  _Device device,
  String name,
  Widget page, {
  bool dark = false,
  Future<void> Function()? interact,
}) async {
  final bloc = CompressBloc(photoCompressorAdapter: _NoopCompressor());

  await tester.pumpWidget(
    RepaintBoundary(
      key: _captureKey,
      child: BlocProvider.value(
        value: bloc,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _theme(AppTheme.light, device.platform),
          darkTheme: _theme(AppTheme.dark, device.platform),
          themeMode: dark ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,
          builder: (context, child) => Stack(
            children: [
              child!,
              if (device.chrome == _Chrome.duoInner)
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 134,
                      height: 5,
                      decoration: BoxDecoration(
                        color: dark ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              if (device.chrome == _Chrome.duoOuter)
                Positioned(
                  right: 45.5,
                  top: 284,
                  child: Container(
                    width: 5,
                    height: 110,
                    decoration: BoxDecoration(
                      color: dark ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  type: MaterialType.transparency,
                  child: _StatusBar(chrome: device.chrome, page: page),
                ),
              ),
            ],
          ),
          home: page,
        ),
      ),
    ),
  );

  await _settle(tester);
  if (interact != null) await interact();
  await _settle(tester);

  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_captureKey),
  );
  final bytes = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: device.pixelRatio);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return data!.buffer.asUint8List();
  });
  final file = File(
    '$_root/screenshots/${device.folder}/${_locale.languageCode}/$name.png',
  );
  file.parent.createSync(recursive: true);
  file.writeAsBytesSync(bytes!);
  expect(tester.takeException(), isNull);
  expect(boundary.size * device.pixelRatio, device.physicalSize);

  await tester.pumpWidget(const SizedBox());
  // Awaiting close() inside the fake-async zone never completes.
  bloc.close();
  await tester.pump();
}

ThemeData _theme(ThemeData base, TargetPlatform platform) =>
    base.copyWith(platform: platform);

class _CompressPage extends StatelessWidget {
  final Widget child;
  final bool showBack;

  const _CompressPage({required this.child, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
          child: Column(
            children: [
              if (showBack) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppActionButton(
                    width: 47,
                    icon: AppIcons.arrowBack,
                    iconWidth: 22,
                    iconHeight: 22,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  final _Chrome chrome;
  final Widget page;

  const _StatusBar({required this.chrome, required this.page});

  @override
  Widget build(BuildContext context) {
    final onPhoto = false;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final color = onPhoto || dark ? Colors.white : const Color(0xFF111111);
    final style = TextStyle(
      fontFamily: chrome == _Chrome.duoOuter || chrome == _Chrome.duoInner
          ? 'DuoStatus'
          : 'StatusBar',
      color: color,
      fontSize: switch (chrome) {
        _Chrome.iphone => 17,
        _Chrome.ipad => 14,
        _Chrome.android => 14,
        _Chrome.duoOuter => 15,
        _Chrome.duoInner => 14,
      },
      fontWeight: FontWeight.w600,
      height: 1,
    );

    return switch (chrome) {
      _Chrome.duoOuter => SizedBox(
        height: 678,
        child: Stack(
          children: [
            Positioned(
              top: 24,
              right: 29.5,
              child: Container(
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0xFF202B39), Colors.black],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 83,
              right: 24,
              child: SizedBox(
                width: 48,
                height: 86,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('9:41', style: style),
                    CustomPaint(
                      size: const Size(20, 13),
                      painter: _DuoIconPainter(color, false),
                    ),
                    CustomPaint(
                      size: const Size(28, 13),
                      painter: _DuoIconPainter(color, true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      _Chrome.duoInner => SizedBox(
        height: 48,
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 24, top: 14),
            child: SizedBox(
              width: 92,
              child: Row(
                children: [
                  Text('9:41', style: style),
                  const Spacer(),
                  _StatusIcons(color: color, scale: 0.85, cellular: false),
                ],
              ),
            ),
          ),
        ),
      ),
      _Chrome.iphone => SizedBox(
        height: 62,
        child: Stack(
          children: [
            Positioned(
              top: 11,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 126,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              width: 150,
              top: 21,
              child: Center(child: Text('9:41', style: style)),
            ),
            Positioned(
              right: 30,
              top: 22,
              child: _StatusIcons(color: color, scale: 1),
            ),
          ],
        ),
      ),
      _Chrome.ipad => SizedBox(
        height: 32,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 9, 22, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('9:41', style: style),
              const Spacer(),
              _StatusIcons(color: color, scale: 0.85, cellular: false),
            ],
          ),
        ),
      ),
      _Chrome.android => SizedBox(
        height: 36,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 20, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('9:30', style: style),
              const Spacer(),
              _StatusIcons(color: color, scale: 0.85),
            ],
          ),
        ),
      ),
    };
  }
}

class _StatusIcons extends StatelessWidget {
  final Color color;
  final double scale;
  final bool cellular;

  const _StatusIcons({
    required this.color,
    required this.scale,
    this.cellular = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size((cellular ? 78 : 54) * scale, 13 * scale),
      painter: _StatusIconsPainter(color, scale, cellular),
    );
  }
}

class _StatusIconsPainter extends CustomPainter {
  final Color color;
  final double scale;
  final bool cellular;

  _StatusIconsPainter(this.color, this.scale, this.cellular);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale);
    final fill = Paint()..color = color;
    var x = 0.0;
    if (cellular) {
      for (var i = 0; i < 4; i++) {
        final h = 4.0 + i * 2.6;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x + i * 4.6, 12 - h, 3.2, h),
            const Radius.circular(1),
          ),
          fill,
        );
      }
      x += 24;
    }
    final wifi = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.1
      ..strokeCap = StrokeCap.round;
    final center = Offset(x + 8.5, 12);
    for (final r in [3.5, 7.2, 10.8]) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        -2.36,
        1.57,
        false,
        wifi,
      );
    }
    canvas.drawCircle(center.translate(0, -0.6), 1.5, fill);
    x += 22;
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, 0.5, 25, 12),
      const Radius.circular(3.6),
    );
    canvas.drawRRect(
      body,
      Paint()
        ..color = color.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 2, 2.5, 21, 8),
        const Radius.circular(2),
      ),
      fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 26.2, 4.5, 1.6, 4),
        const Radius.circular(1),
      ),
      Paint()..color = color.withValues(alpha: 0.45),
    );
  }

  @override
  bool shouldRepaint(_StatusIconsPainter old) =>
      old.color != color || old.scale != scale;
}

class _DuoIconPainter extends CustomPainter {
  final Color color;
  final bool battery;
  _DuoIconPainter(this.color, this.battery);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    // Reuse the same full Wi-Fi / battery geometry as the horizontal system bar.
    canvas.clipRect(Offset.zero & size);
    if (battery) canvas.translate(-22, 0);
    _StatusIconsPainter(color, 1, false).paint(canvas, const Size(54, 13));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DuoIconPainter old) =>
      old.color != color || old.battery != battery;
}

class _NoopCompressor extends PhotoCompressorAdapter {
  @override
  Future<int?> estimateCompressedSize(
    Iterable<PickedPhoto> photos,
    CompressionSettings settings, {
    bool Function()? isCancelled,
  }) async => 0;
  @override
  Future<String?> createThumbnail(String inputPath) async => null;
}
