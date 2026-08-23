import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsService extends ChangeNotifier {
  static const _addMinimoPrefixKey = 'add_minimo_prefix';
  static const _savePhotosToAlbumKey = 'save_photos_to_album';
  static const _languageCodeKey = 'language_code';
  static const _darkThemeKey = 'dark_theme';
  static const appPrefix = 'minimo_';
  static const albumName = 'Minimo';

  static final instance = AppSettingsService._();

  AppSettingsService._();

  late SharedPreferences _preferences;
  bool addMinimoPrefix = true;
  bool savePhotosToAlbum = false;
  String? languageCode;
  bool? darkTheme;

  Locale? get locale => languageCode == null ? null : Locale(languageCode!);
  ThemeMode get themeMode => switch (darkTheme) {
    true => ThemeMode.dark,
    false => ThemeMode.light,
    null => ThemeMode.system,
  };

  Future<void> load() async {
    _preferences = await SharedPreferences.getInstance();
    addMinimoPrefix =
        _preferences.getBool(_addMinimoPrefixKey) ?? addMinimoPrefix;
    savePhotosToAlbum =
        _preferences.getBool(_savePhotosToAlbumKey) ?? savePhotosToAlbum;
    languageCode = _preferences.getString(_languageCodeKey);
    darkTheme = _preferences.getBool(_darkThemeKey);
  }

  Future<void> setAddMinimoPrefix(bool value) =>
      _setBool(_addMinimoPrefixKey, value, (v) => addMinimoPrefix = v);

  Future<void> setSavePhotosToAlbum(bool value) =>
      _setBool(_savePhotosToAlbumKey, value, (v) => savePhotosToAlbum = v);

  Future<void> setDarkTheme(bool value) =>
      _setBool(_darkThemeKey, value, (v) => darkTheme = v);

  Future<void> setLanguageCode(String? value) async {
    languageCode = value;
    if (value == null) {
      await _preferences.remove(_languageCodeKey);
    } else {
      await _preferences.setString(_languageCodeKey, value);
    }
    notifyListeners();
  }

  Future<void> _setBool(
    String key,
    bool value,
    ValueChanged<bool> update,
  ) async {
    update(value);
    await _preferences.setBool(key, value);
    notifyListeners();
  }
}
