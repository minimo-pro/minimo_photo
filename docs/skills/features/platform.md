# Platform Integration

No custom picker or compression method channel is used.

## Selection

- Gallery: `image_picker.pickMultiImage`, maximum 50 items
- Files: `file_picker.pickFiles`, extensions JPG/JPEG/PNG/WebP/HEIC/HEIF

The start and add-more flows share `PhotoFileAdapter` and the same source
sheet. Empty/cancelled selection leaves current state unchanged.

## Compression

`flutter_image_compress` calls native Android/iOS image APIs. Output files are
created under temporary `minimo_photo` storage with collision-safe names.

## Gallery

`gal.putImage` saves successful output files. Android declares legacy write
permission only through API 29; modern Android and iOS use system photo-library
authorization. iOS usage strings live in `Runner/Info.plist`.

