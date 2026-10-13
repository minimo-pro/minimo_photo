import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/changelog_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

PackageInfo _packageInfo(String version) => PackageInfo(
  appName: 'minimo',
  packageName: 'com.khlebobul.minimo_photo',
  version: version,
  buildNumber: '1',
);

void main() {
  test('initialize stays hidden while no releases are documented', () async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': true});
    final service = ChangelogService(
      packageInfo: () async => _packageInfo('1.0.0'),
    );

    expect(await service.initialize(language: Language.en), isNull);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('last_seen_version'), '1.0.0');
  });

  test('unseenChanges returns every version between last seen and current', () {
    final changes = unseenChanges(
      lastSeen: '1.2.0',
      current: '1.5.0',
      language: Language.en,
      changelog: const {
        '1.2.0': {
          Language.en: ['old'],
        },
        '1.3.0': {
          Language.en: ['middle'],
        },
        '1.5.0': {
          Language.en: ['latest'],
        },
      },
    );

    expect(changes, ['middle', 'latest']);
  });

  test('unseenChanges treats malformed lastSeen as never seen', () {
    final changes = unseenChanges(
      lastSeen: 'not-a-version',
      current: '1.5.0',
      language: Language.en,
      changelog: const {
        '1.3.0': {
          Language.en: ['middle'],
        },
        '1.5.0': {
          Language.en: ['latest'],
        },
      },
    );

    expect(changes, ['middle', 'latest']);
  });

  test('initialize discards corrupt last_seen_version and continues', () async {
    SharedPreferences.setMockInitialValues({
      'onboarding_completed': true,
      'last_seen_version': 'corrupt',
    });
    final service = ChangelogService(
      packageInfo: () async => _packageInfo('1.0.0'),
      changelog: {
        '1.0.0': {
          Language.en: ['fresh'],
        },
      },
    );

    final update = await service.initialize(language: Language.en);

    expect(update?.changes, ['fresh']);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('last_seen_version'), isNull);
  });

  test('initialize skips first install and saves current version', () async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': false});
    final service = ChangelogService(
      packageInfo: () async => _packageInfo('1.0.0'),
    );

    expect(await service.initialize(language: Language.en), isNull);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('last_seen_version'), '1.0.0');
  });

  test('currentUpdate stays hidden without a current release entry', () async {
    final service = ChangelogService(
      packageInfo: () async => _packageInfo('1.0.0'),
    );

    expect(await service.currentUpdate(language: Language.ru), isNull);
  });

  test('dismiss saves all unseen releases; currentUpdate can reopen', () async {
    SharedPreferences.setMockInitialValues({
      'onboarding_completed': true,
      'last_seen_version': '1.0.0',
    });
    final service = ChangelogService(
      packageInfo: () async => _packageInfo('1.2.0'),
      changelog: const {
        '1.3.0': {
          Language.en: ['future'],
        },
        '1.2.0': {
          Language.en: ['latest'],
          Language.ru: ['новое'],
        },
        '1.1.0': {
          Language.en: ['middle'],
        },
      },
    );

    final update = await service.initialize(language: Language.ru);
    expect(update?.changes, ['middle', 'новое']);
    await service.dismiss();
    expect(await service.initialize(language: Language.ru), isNull);
    final reopened = await service.currentUpdate(language: Language.ru);
    expect(reopened?.version, '1.2.0');
    expect(reopened?.changes, ['новое']);
  });
}
