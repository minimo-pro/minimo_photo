# minimo (photo): App Store Connect

- Bundle ID: `com.khlebobul.minimoPhoto`.
- Auth profile: `minimo`, stored in System Keychain. Pass it explicitly.
- ASC app ID: `6822256099`, resolved on 2026-10-13.
- App-info ID: `552a7f37-8ca5-41ef-be6a-baf64dbe5134`.
- iOS version ID: `e70ef8be-82bd-4062-a904-8221d0734005` (`1.0.1`,
  `PREPARE_FOR_SUBMISSION`). Do not use the video app's ID.
- Local version: `1.0.1+5` (see `pubspec.yaml`).
- UI/export locale mapping: `en → en-US`, `ru → ru`.
- Canonical local metadata: `metadata/app-info/{en-US,ru}.json` and
  `metadata/version/1.0.1/{en-US,ru}.json`. All metadata is ignored by Git.
- User-provided name, subtitle, description, keywords, and URLs are preserved.
  What's New and promotional text are localized for version 1.0.1.
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
rtk proxy asc --profile minimo metadata pull --app 6822256099 --app-info 552a7f37-8ca5-41ef-be6a-baf64dbe5134 --version 1.0.1 --platform IOS --dir .asc/source/metadata
```

Merge existing URLs, localization mappings and What's New into local metadata
before any later upload request. Never pull over local edits. This setup alone
does not authorize remote writes. The user requested metadata and ready iPhone/
iPad screenshot uploads on 2026-10-13, then Duo screenshots and Header/Search
Results uploads and assignments. This does not authorize review, publication,
Product Page Optimization or unrelated Asset Library assignments.

Upload staging files and reports are under `.asc/upload/`; remote snapshots are
under `.asc/source/`.
English and Russian names, subtitles, descriptions, keywords and promotional
text for version 1.0.0 were uploaded and verified on 2026-10-13. Version 1.0.1
What's New and promotional text for en-US and ru were uploaded and verified on
2026-11-01; the post-upload snapshot is in `.asc/source/metadata-verified/`.
All 24 iPhone 6.9-inch/iPad
13-inch screenshots were verified by order, checksum and `COMPLETE` status.
Six English Duo screenshots were uploaded in alternating order: outer slides
1/3/5, inner slides 2/4/6, without repeated story slides. Order, checksums and
`COMPLETE` status were verified. Duo has no Russian exports yet.
English and Russian Header/Search Results images were uploaded to Asset Library
and assigned to their version localizations; all four placements are `ACTIVE`.
The version remains `PREPARE_FOR_SUBMISSION`.

Exports and browser editor: [store_screenshots/README.md](store_screenshots/README.md).
Apple Header and Search Results use Asset Library placements, separate from
the screenshot decks. Google Play needs separate tooling and credentials.
