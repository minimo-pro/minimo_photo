import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Keeps the sequential Dart batch alive with native runtime and system controls.
class BackgroundCompressionService {
  static const _channel = MethodChannel('minimo_photo/background_compression');
  String? _token;
  int _lastProgress = -1;
  int _lastIndex = -1;

  Future<bool> start({required VoidCallback onCancel}) async {
    if (defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }
    final token = DateTime.now().microsecondsSinceEpoch.toString();
    _token = token;
    _lastProgress = -1;
    _lastIndex = -1;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'cancel' && call.arguments == _token) onCancel();
    });
    var granted = false;
    try {
      granted =
          await _channel.invokeMethod<bool>('start', {'token': token}) ?? false;
    } on PlatformException catch (error) {
      debugPrint('Background compression start failed: ${error.code}');
    } on MissingPluginException {
      // Older native builds retain foreground-only compression.
    }
    if (!granted) {
      _token = null;
      _channel.setMethodCallHandler(null);
    }
    return granted;
  }

  Future<void> update(double progress, int index, int count) async {
    if (_token == null || !progress.isFinite) return;
    final units = (progress.clamp(0, 1) * 1000).floor();
    if (units == _lastProgress && index == _lastIndex) return;
    _lastProgress = units;
    _lastIndex = index;
    await _invoke('update', {
      'progress': progress.clamp(0, 1),
      'index': index,
      'count': count,
    });
  }

  Future<void> finish({required bool success}) async {
    if (_token == null) return;
    await _invoke('finish', {'success': success});
    _token = null;
    _channel.setMethodCallHandler(null);
  }

  Future<void> _invoke(String method, Map<String, Object> arguments) async {
    try {
      await _channel.invokeMethod<void>(method, {
        'token': _token,
        ...arguments,
      });
    } on PlatformException catch (error) {
      debugPrint('Background compression $method failed: ${error.code}');
    } on MissingPluginException {
      // Older native builds retain foreground-only compression.
    }
  }
}
