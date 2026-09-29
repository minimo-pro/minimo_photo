# Platform Integration

Compression uses a package plugin. iOS photo selection and gallery replacement
use the `minimo_photo/photos` method channel in `SceneDelegate.swift`.

## Selection

- iOS gallery: `PHPickerViewController`, maximum 50 items; selected files are
  copied into the app cache with their source identifiers and available metadata
- iOS files: `UIDocumentPickerViewController`, selected files copied to cache
- Android gallery: `image_picker.pickMultiImage`, maximum 50 items
- Android files: `file_picker.pickFiles`, extensions JPG/JPEG/PNG/WebP/HEIC/HEIF

The start and add-more flows share `PhotoFileAdapter` and the same source
sheet. Empty/cancelled selection leaves current state unchanged.

## Compression

`flutter_image_compress` calls native Android/iOS image APIs. Output files are
created under temporary `minimo_photo` storage with collision-safe names.

## Gallery

`gal.putImage` saves successful output files. On iOS, the native channel can
also save a replacement with source date/location metadata and, after a
successful save, request deletion of selected originals. Android declares
legacy write permission only through API 29; modern Android and iOS use system
photo-library authorization. iOS usage strings live in `Runner/Info.plist`.
