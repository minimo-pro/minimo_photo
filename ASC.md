# minimo (photo): App Store Connect

- Bundle ID: `com.khlebobul.minimoPhoto`.
- Auth profile: `minimo`, stored in System Keychain. Pass it explicitly.
- ASC app ID: unresolved. On 2026-10-11 this profile returned no app matching
  the bundle ID. Do not use the video app's ID or create an app automatically.
- Local version: `1.0.0` (see `pubspec.yaml` for the current build number).
- UI/export locale mapping: `en → en-US`, `ru → ru`.
- Canonical local metadata: `metadata/app-info/{en-US,ru}.json` and
  `metadata/version/1.0.0/{en-US,ru}.json`. All metadata is ignored by Git.
- User-provided name, subtitle, description, keywords and promotional text are
  preserved. What's New is a draft based on `CHANGELOG.md`'s initial release.
- Support/privacy/marketing URLs are pending: no matching ASC app or existing
  project values were available. They are omitted, not replaced with invented
  URLs. Metadata length/schema validation is not release-readiness validation.

Use installed `asc-cli-usage`, `asc-id-resolver` and `asc-metadata-sync` skills.
Discover current flags with `asc <command> --help` before running commands.

```bash
rtk proxy asc --profile minimo apps list --bundle-id com.khlebobul.minimoPhoto --output json
rtk proxy asc --profile minimo metadata validate --dir ./metadata --output table
```

After the app exists, resolve its app-info record and version, then pull into
a separate source folder. Replace `APP_ID` and `APP_INFO_ID` with resolved IDs:

```bash
rtk proxy asc --profile minimo apps info list --app APP_ID --output table
rtk proxy asc --profile minimo versions list --app APP_ID --output table
rtk proxy asc --profile minimo metadata pull --app APP_ID --app-info APP_INFO_ID --version 1.0.0 --platform IOS --dir .asc/source/metadata
```

Merge existing URLs, localization mappings and What's New into local metadata
before any later upload request. Never pull over local edits. No remote writes
are authorized by this setup, including uploads, version creation, review,
publication, Product Page Optimization or Asset Library assignments.

Exports and browser editor: [store_screenshots/README.md](store_screenshots/README.md).
Apple Header and Search Results are prepared as local creative assets, separate
from the screenshot decks. Google Play needs separate tooling and credentials.
