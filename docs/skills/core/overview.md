# Overview

`minimo (photo)` is a Flutter app for private, on-device photo compression on
iOS and Android. Photos are never uploaded.

## Product scope

- Pick one or many photos from gallery or files
- Add more photos before compression starts
- Choose a preset or advanced quality, dimension, and EXIF settings
- Compress sequentially, cancel safely, compare, save, and share
- Keep originals untouched

## Main entry points

| Area | Path |
|---|---|
| App bootstrap | `lib/main.dart` |
| Routes | `lib/router/` |
| Start screen | `lib/screens/start_page.dart` |
| Compression feature | `lib/features/compression/` |
| Settings/services | `lib/services/` |
| Localization | `lib/l10n/` |
| Shared UI | `lib/widgets/` |

