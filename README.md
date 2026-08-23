# minimo (photo)

Private, on-device photo compression for iOS and Android. Same product and UI
structure as `minimo_video`, adapted to still images.

## MVP

- Pick multiple photos from gallery or files
- High, medium, and low presets
- Advanced JPEG quality, maximum dimension, and EXIF controls
- Sequential batch compression with progress and cancellation
- Before/after comparison, gallery save, and sharing
- English and Russian localization

Originals are never modified. Compression runs locally through
[`flutter_image_compress`](https://pub.dev/packages/flutter_image_compress).

## Run

```bash
flutter pub get
dart run intl_utils:generate
dart run build_runner build
flutter run
```

## Verify

```bash
flutter analyze
flutter test
```

Architecture and feature documentation: [`docs/README.md`](docs/README.md).

