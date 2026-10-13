import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_launch_service.dart';

enum Language {
  en('en'),
  ru('ru');

  final String code;

  const Language(this.code);

  static Language fromCode(String? code) => switch (code) {
    'ru' => Language.ru,
    _ => Language.en,
  };
}

typedef Changelog = Map<String, Map<Language, List<String>>>;

// Add localized entries here when app updates are released.
const Changelog _changelog = {};

List<String> unseenChanges({
  required String lastSeen,
  required String current,
  required Language language,
  Changelog changelog = _changelog,
}) {
  final lastSeenVersion = _tryParseVersion(lastSeen) ?? Version(0, 0, 0);
  final currentVersion = _tryParseVersion(current);
  if (currentVersion == null) return const [];

  final result = <String>[];
  final entries = <({Version version, Map<Language, List<String>> texts})>[];
  for (final entry in changelog.entries) {
    final entryVersion = _tryParseVersion(entry.key);
    if (entryVersion == null) continue;
    entries.add((version: entryVersion, texts: entry.value));
  }
  entries.sort((a, b) => a.version.compareTo(b.version));

  for (final entry in entries) {
    if (entry.version > lastSeenVersion && entry.version <= currentVersion) {
      result.addAll(entry.texts[language] ?? entry.texts[Language.en] ?? []);
    }
  }

  return result;
}

Version? _tryParseVersion(String value) {
  try {
    return Version.parse(value);
  } on FormatException {
    return null;
  }
}

class ChangelogUpdate {
  final String version;
  final List<String> changes;

  const ChangelogUpdate({required this.version, required this.changes});
}

class ChangelogService {
  static const _lastSeenVersionKey = 'last_seen_version';
  static final instance = ChangelogService();

  final Future<PackageInfo> Function() _packageInfo;
  final Future<SharedPreferences> Function() _preferences;
  final Changelog _changes;

  String? _currentVersion;

  ChangelogService({
    Future<PackageInfo> Function()? packageInfo,
    Future<SharedPreferences> Function()? preferences,
    Changelog changelog = _changelog,
  }) : _packageInfo = packageInfo ?? PackageInfo.fromPlatform,
       _preferences = preferences ?? SharedPreferences.getInstance,
       _changes = changelog;

  Future<ChangelogUpdate?> currentUpdate({required Language language}) async {
    final current = (await _packageInfo()).version;
    _currentVersion = current;
    final texts = _changes[current];
    if (texts == null) return null;

    final changes = texts[language] ?? texts[Language.en] ?? const [];
    if (changes.isEmpty) return null;
    return ChangelogUpdate(version: current, changes: changes);
  }

  Future<ChangelogUpdate?> initialize({required Language language}) async {
    final current = (await _packageInfo()).version;
    _currentVersion = current;

    final prefs = await _preferences();
    final lastSeenRaw = prefs.getString(_lastSeenVersionKey);
    final lastSeen = lastSeenRaw == null
        ? null
        : (_tryParseVersion(lastSeenRaw) == null ? null : lastSeenRaw);

    if (lastSeenRaw != null && lastSeen == null) {
      await prefs.remove(_lastSeenVersionKey);
    }

    if (lastSeen == null && await FirstLaunchService.shouldShowOnboarding()) {
      await prefs.setString(_lastSeenVersionKey, current);
      return null;
    }

    if (lastSeen == current) return null;

    final changes = unseenChanges(
      lastSeen: lastSeen ?? '0.0.0',
      current: current,
      language: language,
      changelog: _changes,
    );

    if (changes.isEmpty) {
      await prefs.setString(_lastSeenVersionKey, current);
      return null;
    }

    return ChangelogUpdate(version: current, changes: changes);
  }

  Future<void> markCurrentVersionSeen() async {
    final version = _currentVersion ?? (await _packageInfo()).version;
    final prefs = await _preferences();
    await prefs.setString(_lastSeenVersionKey, version);
  }

  Future<void> dismiss() async {
    await markCurrentVersionSeen();
  }
}
