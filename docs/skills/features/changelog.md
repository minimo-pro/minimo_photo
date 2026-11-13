# Changelog

## In-App Changelog

`ChangelogService` stores a local versioned changelog map in Dart. Keys are semantic versions, language keys use the `Language` enum, and version comparisons use `pub_semver`. Keep this map aligned with root [`CHANGELOG.md`](../../../CHANGELOG.md); it contains notes through version `1.0.7`.

Add localized entries to `_changelog` in [`changelog_service.dart`](../../../lib/services/changelog_service.dart) when updates ship:

```dart
const Changelog _changelog = {
  '1.0.2': {
    Language.en: ['describe the update here.'],
    Language.ru: ['опишите обновление здесь.'],
  },
};
```

The changelog works offline and does not fetch remote data.

## Seen Version

`last_seen_version` is stored in `shared_preferences`. First install is skipped and saves the current version. Existing users without `last_seen_version` are treated as update users and can see bundled entries up to the current version.

`unseenChanges()` returns every entry where:

```text
lastSeen < entryVersion <= current
```

so users jumping multiple releases see all unseen changes.

## UI

`StartPage` waits for the upgrader check to finish (and for any
`UpgradeAlert` prompt to be dismissed) before showing the changelog sheet.
If unseen changes exist, `showChangelogDialog()` presents a content-sized
`stupid_simple_sheet` (scroll-to-drag dismiss). Dismissing the sheet marks
the current version as seen.

The About screen includes a What's New link when `currentUpdate()` finds
nonempty notes for the installed version. It reopens that version's notes even
after dismissal. With an empty map, both the automatic sheet and this link stay
hidden.

## Release Checklist

- Update root `CHANGELOG.md` and group entries under category headings such as `### Added`.
- Add a local `_changelog` entry for every app version.
- Localize the current release for every supported app language.
- Write in-app changelog headings and entries in lowercase in every language.

---

[Back to SKILLS.md](../../SKILLS.md)
