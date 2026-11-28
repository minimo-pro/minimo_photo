# minimo (photo): App Store Connect

- Bundle ID: `com.khlebobul.minimoPhoto`.
- Auth profile: `minimo`, stored in System Keychain. Pass it explicitly.
- ASC app ID: `6822256099`, resolved on 2026-10-13.
- App-info ID used for the latest verified pull: `8b1599cd-b75c-467d-ac74-e408f7e95154`.
- iOS version ID: `d63fc125-446f-4787-8b35-76994a54853e` (`1.1.3`,
  `PREPARE_FOR_SUBMISSION`). Live version: `1.1.2`, ID
  `b359c141-74e8-4fc7-8c09-e5fe42ef320d`.
- Local version: `1.1.3+18` (see `pubspec.yaml`).
- ASC CLI: `7.0.0`, updated with Homebrew and verified on 2026-11-19.
- UI/export locales: `en`, `de`, `es`, `fr`, `hi`, `it`, `ja`, `ko`, `nl`,
  `pt`, `ru`, `tr`, `zh`. App Store mapping: `en → en-US`, `de → de-DE`,
  `es → es-ES`, `fr → fr-FR`, `nl → nl-NL`, `pt → pt-BR`, `zh → zh-Hans`;
  the others use the same code. `zh-Hant` has separate App Store metadata,
  without a separate UI deck.
- Canonical local metadata: `metadata/app-info/*.json` and
  `metadata/version/{1.0.0,1.0.1,1.0.2,1.0.3,1.0.4,1.0.5,1.0.6,1.0.7,1.0.8,1.1.0,1.1.2,1.1.3}/*.json` (14 App Store locales).
  Google Play listings: `metadata/google-play/store-listing-import.csv`
  (13 locales). All metadata is ignored by Git.
- User-provided name, subtitle, description, and URLs are preserved.
  What's New and promotional text for version 1.1.3 are localized in all 14
  App Store locales; descriptions, keywords and URLs are preserved from live
  1.1.2. Metadata validation is not release-readiness validation.

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

On 2026-11-14, after the Guideline 2.3.7 rejection of 1.0.7 (12), pricing
references were removed from local screenshot copy in all 13 UI languages.
All 14 App Store localizations had their iPhone, iPad and Duo screenshot sets
replaced for version 1.0.7. The full readback verified all 252 screenshots by
order, MD5 and `COMPLETE` status. Snapshot:
`.asc/source/1.0.7-pricing-fix/screenshots-verified.json`; staging and receipts:
`.asc/upload/1.0.7-pricing-fix/`. Local export validation passed for 429 RGB
PNGs and 14 ZIPs. Text metadata and creative assignments were not changed.
No review reply, resubmission or publication was performed.

On 2026-11-16, version 1.0.8 was created as `PREPARE_FOR_SUBMISSION`,
copying metadata from live version 1.0.7. What's New describes sharing
photo-compression statistics; promotional text highlights making room for
memories and sharing the compressed-photo count and space saved. Both fields
were uploaded and verified for all 14 App Store locales. All version fields
match `metadata/version/1.0.8/`; descriptions, keywords, and URLs are preserved.
Readback: `.asc/source/metadata-1.0.8-verified/`. Upload receipt:
`.asc/upload/metadata-1.0.8-text-result.json`. No build was uploaded or attached,
and no review submission or publication was performed.

On 2026-11-19, ASC CLI was upgraded from 5.13.0 to 7.0.0. Version 1.1.0 was
created as `PREPARE_FOR_SUBMISSION`, preserving descriptions, keywords and URLs
from live 1.0.8. What's New covers background import/compression on supported
devices and the refreshed introduction; promotional text highlights making room
for memories with on-device background processing. Both fields were uploaded
and verified for all 14 App Store locales. The complete version metadata matches
`metadata/version/1.1.0/`; app-info was unchanged. Readback:
`.asc/source/metadata-1.1.0-verified/`. Drafts, dry run, receipts and version state:
`.asc/upload/1.1.0-text/`. No build was uploaded or attached; no review submission
or publication was performed.

On 2026-11-23, version 1.1.2 was created as `PREPARE_FOR_SUBMISSION`, copying
metadata from live 1.1.0. What's New covers reporting a photo problem from the
About screen, easier website and contact links, and an update dialog that
follows the app theme and language. Promotional text keeps the memory-space
theme and adds the About-screen report. Both fields were uploaded and verified
for all 14 App Store locales. Descriptions, keywords, and URLs match 1.1.0.
The complete version metadata matches `metadata/version/1.1.2/`; app-info was
unchanged. Readback: `.asc/source/metadata-1.1.2-verified/`. Drafts, dry run,
receipts and version state: `.asc/upload/1.1.2-text/`. No build was uploaded or
attached, and no review submission or publication was performed.
