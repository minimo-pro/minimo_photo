# Agent instructions

- Prefix shell commands with `rtk`; use `rtk proxy` for other commands.
- Keep replies concise. Preserve unrelated user changes.
- For store screenshots, use the installed `app-store-screenshots` skill and read
  [store_screenshots/README.md](store_screenshots/README.md). Capture production
  widgets with `test/store_screenshots/capture_test.dart`; supported UI locales
  are `en` and `ru`. Keep deck settings tracked, images and exports local except
  `docs/images/store-preview.png`.
- For App Store Connect work, read [ASC.md](ASC.md). Use `asc-cli-usage` for
  command discovery, `asc-id-resolver` for IDs, and `asc-metadata-sync` for
  canonical metadata. Use signing/build/release/TestFlight skills only when
  those workflows are requested. Always pass `--profile minimo`; never change
  the global profile. Pull remote data into `.asc/source/`, preserving local
  `metadata/` edits and existing support/privacy/marketing URLs.
- Local validation and read-only ASC discovery are permitted. Remote writes,
  uploads, app/version creation, submissions and publication require a separate
  user request. No Product Page Optimization experiments or variants are part
  of local screenshot preparation.
