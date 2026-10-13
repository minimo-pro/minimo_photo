# minimo (photo) store screenshots

Next.js editor adapted from the `app-store-screenshots` template and this app's
Pangolin font, sky backgrounds and red controls. Only **en** and **ru** are
supported, matching `lib/l10n/intl_*.arb`.

## Start and restore

Run from the repository root. Requires Node >=20.9, Flutter, Python 3, curl and
Chrome. Dependencies are pinned in `package-lock.json`; use `npm ci` after
cloning. A virtual environment keeps Python dependencies out of the global
installation:

```bash
python3 -m venv store_screenshots/.venv
store_screenshots/.venv/bin/pip install -r store_screenshots/requirements.txt
store_screenshots/.venv/bin/python store_screenshots/scripts/restore-assets.py
flutter test test/store_screenshots/capture_test.dart
cd store_screenshots
npm ci
npm run dev -- --hostname 127.0.0.1 --port 3002
```

Editor: <http://127.0.0.1:3002>. Select iOS/Android, device and language; edit
headlines in the inspector or canvas. Changes save to the Git-tracked
`app-store-screenshots.json`. This file takes precedence over stale browser
storage; a failed file load blocks autosave. Project writes use a temporary
file and atomic rename. Reset loads the saved starter decks bundled at build
time; retain Git history before replacing those settings.

The Android **Feature Graphic** is a real editable deck. Its editor export and
`/creative?kind=play` preview use the same renderer/settings. The Apple Header
and Search Results have separate previews; their composition is in
`src/app/creative/page.tsx`, translations in `src/lib/store-copy.json`.

## Capture and export

Capture runs production Flutter settings, progress, results and comparison
widgets, with real `PickedPhoto`/`CompressState` models and file sizes from
demo JPEGs. Comparison opens through the result screen's actual button.
The demo compressor only isolates native calls; this is a widget capture,
not a simulator or hardware compression test. JPEG fixture copies use quality
82 and unchanged dimensions, matching the default preset's dimension limit.
Preferences are mocked; no personal Photos library or real saved settings are
read. Capture tests skip in ordinary test runs when local demo assets are absent.

Pangolin covers both languages. All marketing text fitting includes word and
letter spacing; no decorative background circles are used. Device screen
ratios match captures; the Android camera is inside the screen.

With the editor running, execute from the repository root:

```bash
store_screenshots/.venv/bin/python store_screenshots/scripts/export.py
store_screenshots/.venv/bin/python store_screenshots/scripts/export.py --check
store_screenshots/.venv/bin/python store_screenshots/scripts/browser-check.py
flutter analyze
```

The browser check clicks the actual **Export bundle** button for iPhone, iPad,
Android and Feature Graphic; opens every downloaded PNG; checks both locales,
dimensions, no alpha channel, nonblank pixels and ZIP integrity. It also checks
editing, saving, language switching, rejection of invalid project JSON and
stale-cache protection, then restores the original settings. Close other
editor tabs during this check so concurrent edits aren't overwritten.

`BASE` overrides the browser-check URL; `export.py --base URL` overrides the
exporter URL. `CHROME` can override the browser executable (default: Chrome's
standard macOS installation). Export regenerates PNGs, all contact sheets,
the README image and all ZIPs together. Rerun capture first after UI changes.

| Asset | PNG size | Local output |
|---|---|---|
| iPhone 6.9-inch | 1320 × 2868 | `export/apple/iphone-6.9/{en,ru}/01–06.png` |
| iPad 13-inch | 2064 × 2752 | `export/apple/ipad-13/{en,ru}/01–06.png` |
| Android phone | 1080 × 1920 | `export/android/phone/{en,ru}/01–06.png` |
| Android Feature Graphic | 1024 × 500 | `export/android/feature-graphic/{en,ru}/01.png` |
| Apple Header | 3840 × 1646 | `export/apple/header/{en,ru}/01.png` |
| Apple Search Results | 3840 × 2560 | `export/apple/search-results/{en,ru}/01.png` |

There are **42 PNGs**, 21 per language. Each deck follows the same story:
hero, before/after, batch, on-device privacy (dark), advanced settings and a
feature wall. Chips only state verified app features. ZIPs: `export/minimo-photo-en.zip`,
`export/minimo-photo-ru.zip`, `export/minimo-photo-all.zip`. Contact sheets:
`export/previews/{iphone,ipad,android,en,ru,banners}.png`. The public README
overview is `docs/images/store-preview.png`, without labels or service bars.

Preview routes:

- `/preview?device=iphone&locale=ru&h=640`
- `/preview?device=ipad&locale=en&h=640`
- `/preview?device=android&locale=ru&h=640`
- `/creative?kind=play&locale=ru`
- `/creative?kind=header&locale=en`
- `/creative?kind=search&locale=ru`

Sizes/formats checked 2026-10-11 against [Apple screenshots](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications),
[Apple creative assets](https://developer.apple.com/help/app-store-connect/reference/app-information/creative-assets-specifications)
and [Google Play preview assets](https://support.google.com/googleplay/android-developer/answer/9866151).
All finished PNGs use RGB without an alpha channel. This prepares local files;
it does not establish release readiness or upload anything.

## Files and credits

Track editor code, capture/export scripts, settings, docs, asset source URLs,
`requirements.txt` and `package-lock.json`. `public/`, `export/`, `reports/`,
`metadata/` and `.asc/` stay local. Only the clean public README overview is
an explicit Git exception. No generated store assets were previously tracked.

`restore-assets.py` rebuilds fonts/icon/backgrounds from tracked app assets,
downloads a checksum-verified pinned template mockup and five public
[Unsplash](https://unsplash.com/license) sample photos listed in
`asset-sources.json`. For offline/custom fixtures, pass `--photos-dir DIR`
containing `beach.jpg`, `dog.jpg`, `birthday.jpg`, `mountains.jpg`, `concert.jpg`;
the first restoration still needs the pinned mockup or a retained local copy.
It also renders `brand/compare-{en,ru}.png`: the beach photo split between the
original and its quality-82 copy, labelled with their real file sizes.
Uploaded screenshots are local too; retain them separately when cloning.

Local store texts and ASC instructions: [../ASC.md](../ASC.md).

- Editor skill: [Parth Jadhav's app-store-screenshots](https://github.com/ParthJadhav/app-store-screenshots),
  author [@parthjadhav8](https://x.com/parthjadhav8). Upstream editor license:
  [MIT](https://github.com/ParthJadhav/app-store-screenshots/blob/main/LICENSE).
- Metadata skill: [asc-metadata-sync](https://github.com/rorkai/app-store-connect-cli-skills/tree/main/skills/asc-metadata-sync)
  and [App Store Connect CLI](https://github.com/rorkai/App-Store-Connect-CLI),
  by [Rudrank Riyam](https://x.com/rudrank).

Apps made with the editor skill: <https://www.parthjadhav.com/products/app-store-screenshots>.
Tag **@parthjadhav8** on Twitter to request inclusion in its showcase.

## iPhone Duo — English review

Two additional portrait decks (`duo-outer`, `duo-inner`) reuse the iPhone
story/copy and tablet composition. Existing iPhone 6.9-inch assets stay intact.
Duo copy and captures currently contain English only; other locales wait for
approval. The editor exports only locales present in every slide headline.

```bash
flutter test test/store_screenshots/capture_test.dart --plain-name 'capture apple/duo'
store_screenshots/.venv/bin/python store_screenshots/scripts/export.py --devices duo-outer duo-inner --locale en
store_screenshots/.venv/bin/python store_screenshots/scripts/export.py --devices duo-outer duo-inner --locale en --check
store_screenshots/.venv/bin/python store_screenshots/scripts/browser-check.py --devices duo-outer duo-inner
```

Duo status text loads macOS SF from `/System/Library/Fonts/SFNS.ttf`; Pangolin
remains the real app font. Flutter capture renders at @3x: outer 466 × 678 pt,
insets top/bottom 24 pt and right 84 pt; inner 669 × 951 pt, top 48 pt and
bottom 24 pt. System chrome is painted separately. These are widget captures,
not an iOS 27.1 simulator / hardware compatibility certification.

- Outer: `export/apple/iphone-duo-outer/en/01–06.png`, 1398 × 2034 RGB.
- Inner: `export/apple/iphone-duo-inner/en/01–06.png`, 2007 × 2853 RGB.
- Review sheets: `export/previews/duo-outer.png`, `duo-inner.png`.
- Preview: `/preview?device=duo-outer&locale=en&h=640` (or `duo-inner`).

Frame geometry follows the requested marketing bezels and the existing
`minimo_video` Duo implementation: star-white titanium, asymmetric outer
corners, no inner camera cutout, and a faint horizontal inner crease.
The sixth slide retains the existing feature wall with app icon.
