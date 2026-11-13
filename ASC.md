# minimo (photo): App Store Connect

- Bundle ID: `com.khlebobul.minimoPhoto`.
- Auth profile: `minimo`, stored in System Keychain. Pass it explicitly.
- ASC app ID: `6822256099`, resolved on 2026-10-13.
- App-info ID used for the latest verified pull: `da4c4c77-e58b-4335-9ad3-31179a1bcd76`.
- iOS version ID: `390680fd-71a0-48ca-93d9-3185d9b3b2b1` (`1.0.7`,
  `PREPARE_FOR_SUBMISSION`). Live version: `1.0.6`, ID
  `5d068855-7ede-41e0-870a-0200709f752c`. Do not use the video app's ID.
- Local version: `1.0.7+12` (see `pubspec.yaml`).
- UI/export locales: `en`, `de`, `es`, `fr`, `hi`, `it`, `ja`, `ko`, `nl`,
  `pt`, `ru`, `tr`, `zh`. App Store mapping: `en → en-US`, `de → de-DE`,
  `es → es-ES`, `fr → fr-FR`, `nl → nl-NL`, `pt → pt-BR`, `zh → zh-Hans`;
  the others use the same code. `zh-Hant` has separate App Store metadata,
  without a separate UI deck.
- Canonical local metadata: `metadata/app-info/*.json` and
  `metadata/version/{1.0.0,1.0.1,1.0.2,1.0.3,1.0.4,1.0.5,1.0.6,1.0.7}/*.json` (14 App Store locales).
  Google Play listings: `metadata/google-play/store-listing-import.csv`
  (13 locales). All metadata is ignored by Git.
- User-provided name, subtitle, description, and URLs are preserved.
  Keywords and What's New are localized for version 1.0.5; promotional text
  carries over from 1.0.4.
  Metadata validation is not release-readiness validation.

Use installed `asc-cli-usage`, `asc-id-resolver` and `asc-metadata-sync` skills.
Discover current flags with `asc <command> --help` before running commands.

```bash
rtk proxy asc --profile minimo apps list --bundle-id com.khlebobul.minimoPhoto --output json
rtk proxy asc --profile minimo metadata validate --dir ./metadata --output table
```

Pull into a separate source folder, preserving local metadata edits:

```bash
rtk proxy asc --profile minimo apps info list --app 6822256099 --output table
rtk proxy asc --profile minimo versions list --app 6822256099 --output table
rtk proxy asc --profile minimo metadata pull --app 6822256099 --app-info fe777da5-0154-482a-91a3-d90cb54e9015 --version 1.0.5 --platform IOS --dir .asc/source/metadata
```

Merge existing URLs, localization mappings and What's New into local metadata
before any later upload request. Never pull over local edits. This setup alone
does not authorize remote writes. The user requested metadata and ready iPhone/
iPad screenshot uploads on 2026-10-13, then Duo screenshots and Header/Search
Results uploads and assignments. On 2026-11-04, the user requested all new
screenshots, promotional assets, app info and What's New for every locale.
This does not authorize review, publication,
Product Page Optimization or unrelated Asset Library assignments.

Upload staging files and reports are under `.asc/upload/`; remote snapshots are
under `.asc/source/`.
English and Russian names, subtitles, descriptions, keywords and promotional
text for version 1.0.0 were uploaded and verified on 2026-10-13. Version 1.0.1
What's New and promotional text for en-US and ru were uploaded and verified on
2026-11-01; the post-upload snapshot is in `.asc/source/metadata-verified/`.
All 24 iPhone 6.9-inch/iPad
13-inch screenshots were verified by order, checksum and `COMPLETE` status.
For 1.0.1, six English Duo screenshots were uploaded in alternating order:
outer slides 1/3/5, inner slides 2/4/6. Order, checksums and `COMPLETE` status
were verified.
English and Russian Header/Search Results images were uploaded to Asset Library
and assigned to their version localizations for 1.0.1.

For 1.0.3, all 14 App Store localizations have matching app info and version
metadata; the verified pull is in `.asc/source/metadata-1.0.3-promo-verified/`.
Promotional text reuses the benefit-focused copy from 1.0.0 in every locale.
All 14 locales have six iPhone, six iPad and six Duo screenshots, with Duo
alternating outer slides 1/3/5 and inner slides 2/4/6. Upload receipts for all
252 show `COMPLETE` in upload results or readbacks; the final full remote
readback is pending because App Store Connect returned HTTP 429. All 28
Header/Search Results placements are
`ACTIVE`. The version is `READY_FOR_DISTRIBUTION`. `zh-Hant` storefront graphics
reuse the `zh` (Simplified Chinese) UI captures because the app has no separate
Traditional Chinese interface.

For 1.0.4, the iOS version was created on 2026-11-05. Promotional text and
What's New were uploaded and verified in all 14 locales. The remote snapshot
is in `.asc/source/metadata-1.0.4-verified/`. No build was uploaded or
submitted for review.

For 1.0.5, the iOS version was created on 2026-11-07 as
`PREPARE_FOR_SUBMISSION`. Metadata was copied from 1.0.4, then ASO keyword
fixes and localized What's New were uploaded for all 14 locales. The exact
remote readback is in `.asc/source/metadata-1.0.5-aso-verified/`. No build was
attached or review submission created in this workflow.

Version 1.0.6 is live. Its metadata was pulled before preparing 1.0.7 into
`.asc/source/metadata-1.0.6-before-1.0.7/`.

For 1.0.7, the iOS version was created on 2026-11-13 as
`PREPARE_FOR_SUBMISSION`. Existing metadata and promotional text were copied
from 1.0.6 for all 14 locales. What's New describes photo-saving bug fixes
without platform-specific wording. Both text fields were verified against
`metadata/version/1.0.7/`; the remote readback is in
`.asc/source/metadata-1.0.7-verified/` and the upload receipt is
`.asc/upload/metadata-1.0.7-text-result.json`. Descriptions, keywords and URLs
match the previous version. No build was attached or review submission created.

Exports and browser editor: [store_screenshots/README.md](store_screenshots/README.md).
Apple Header and Search Results use Asset Library placements, separate from
the screenshot decks. Google Play needs separate tooling and credentials.
