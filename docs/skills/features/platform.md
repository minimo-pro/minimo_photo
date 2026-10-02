# Platform Integration

Compression uses a package plugin. Photo selection uses the
`minimo_photo/photos` method channel in `SceneDelegate.swift` on iOS and
`MainActivity.kt` on Android. iOS gallery replacement uses the same channel.

## Selection

- iOS gallery: `PHPickerViewController`, maximum 50 items; selected files are
  copied into the app cache with their source identifiers and available metadata
- iOS files: `UIDocumentPickerViewController`, selected files copied to cache
- Android gallery: system photo picker on Android 13+, content picker on older
  versions; maximum 50 items
- Android files: system document picker for images

The start and add-more flows share `PhotoFileAdapter` and the same source
sheet. Both native pickers send `pickProgress` after selection and as files are
copied, so the settings screen stays interactive during cloud downloads and
large-file copies. Empty initial selection returns to the start screen;
empty add-more selection leaves current settings and photos unchanged.

## Compression

`flutter_image_compress` calls native Android/iOS image APIs. Output files are
created under temporary `minimo_photo` storage with collision-safe names.

## Gallery

`gal.putImage` saves successful output files. On iOS, the native channel can
also save a replacement with source date/location metadata and, after a
successful save, request deletion of selected originals. Android declares
legacy write permission only through API 29; modern Android and iOS use system
photo-library authorization. iOS usage strings live in `Runner/Info.plist`.

## External photo imports

- Android accepts `ACTION_SEND` and `ACTION_SEND_MULTIPLE` for images, copies up to 50 URIs into app cache, then opens `CompressRoute`.
- iOS Share Extension and the `Compress Photos in minimo` Shortcut stage files in the `group.com.khlebobul.minimoPhoto` App Group inbox. The app copies a complete request into `picked_photos` before opening `CompressRoute`; the Shortcut quality preset becomes the initial setting.
- Share Extension finishes after staging. Open minimo from the Home Screen to continue.

## Screen awake

When `prevent_screen_sleep` is enabled, `wakelock_plus` keeps the display awake while photos import through the picker and while a batch compresses. The app releases it on completion, cancellation, or leaving the import screen.
