// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:collection/collection.dart' as _i12;
import 'package:flutter/material.dart' as _i9;
import 'package:minimo_photo/features/compression/domain/compression_settings.dart'
    as _i2;
import 'package:minimo_photo/features/compression/domain/photo_pick_source.dart'
    as _i11;
import 'package:minimo_photo/features/compression/domain/picked_photo.dart'
    as _i10;
import 'package:minimo_photo/features/compression/presentation/compress_screen.dart'
    as _i1;
import 'package:minimo_photo/screens/info_screen.dart' as _i3;
import 'package:minimo_photo/screens/onboarding_screen.dart' as _i4;
import 'package:minimo_photo/screens/settings_screen.dart' as _i5;
import 'package:minimo_photo/screens/splash_screen.dart' as _i6;
import 'package:minimo_photo/screens/start_page.dart' as _i7;

/// generated route for
/// [_i1.CompressScreen]
class CompressRoute extends _i8.PageRouteInfo<CompressRouteArgs> {
  CompressRoute({
    _i9.Key? key,
    List<_i10.PickedPhoto> initialPhotos = const [],
    _i2.CompressionSettings initialSettings = const _i2.CompressionSettings(),
    _i11.PhotoPickSource? initialPickSource,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         CompressRoute.name,
         args: CompressRouteArgs(
           key: key,
           initialPhotos: initialPhotos,
           initialSettings: initialSettings,
           initialPickSource: initialPickSource,
         ),
         initialChildren: children,
       );

  static const String name = 'CompressRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompressRouteArgs>(
        orElse: () => const CompressRouteArgs(),
      );
      return _i1.CompressScreen(
        key: args.key,
        initialPhotos: args.initialPhotos,
        initialSettings: args.initialSettings,
        initialPickSource: args.initialPickSource,
      );
    },
  );
}

class CompressRouteArgs {
  const CompressRouteArgs({
    this.key,
    this.initialPhotos = const [],
    this.initialSettings = const _i2.CompressionSettings(),
    this.initialPickSource,
  });

  final _i9.Key? key;

  final List<_i10.PickedPhoto> initialPhotos;

  final _i2.CompressionSettings initialSettings;

  final _i11.PhotoPickSource? initialPickSource;

  @override
  String toString() {
    return 'CompressRouteArgs{key: $key, initialPhotos: $initialPhotos, initialSettings: $initialSettings, initialPickSource: $initialPickSource}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompressRouteArgs) return false;
    return key == other.key &&
        const _i12.ListEquality<_i10.PickedPhoto>().equals(
          initialPhotos,
          other.initialPhotos,
        ) &&
        initialSettings == other.initialSettings &&
        initialPickSource == other.initialPickSource;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i12.ListEquality<_i10.PickedPhoto>().hash(initialPhotos) ^
      initialSettings.hashCode ^
      initialPickSource.hashCode;
}

/// generated route for
/// [_i3.InfoScreen]
class InfoRoute extends _i8.PageRouteInfo<void> {
  const InfoRoute({List<_i8.PageRouteInfo>? children})
    : super(InfoRoute.name, initialChildren: children);

  static const String name = 'InfoRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.InfoScreen();
    },
  );
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i8.PageRouteInfo<void> {
  const OnboardingRoute({List<_i8.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i5.SettingsScreen]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}

/// generated route for
/// [_i7.StartPage]
class StartRoute extends _i8.PageRouteInfo<void> {
  const StartRoute({List<_i8.PageRouteInfo>? children})
    : super(StartRoute.name, initialChildren: children);

  static const String name = 'StartRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.StartPage();
    },
  );
}
