# Photo Compression

## Settings

Simple presets:

| Preset | Quality | Maximum side |
|---|---:|---:|
| High | 90 | Original |
| Medium | 82 | 2560 px |
| Low | 72 | 1600 px |

Advanced mode exposes quality `60–95`, original or fixed maximum dimension,
and EXIF preservation.

JPEG and WebP sources are written as JPEG; PNG sources stay PNG. HEIC/HEIF
sources stay HEIC on iOS and become JPEG on Android. Flutter reads input
dimensions to turn the maximum side into proportional encoder dimensions;
the native plugin corrects orientation. An output is accepted only when it is
at least 10% smaller; otherwise the temporary file is deleted and the item is
marked skipped. At medium quality, a 2500-pixel photo is not resized, so it
may be skipped even when other photos in the batch compress successfully.

## Batch lifecycle

1. `PhotoFileAdapter` returns `PickedPhoto` models.
2. `CompressBloc` deduplicates by name and size and prepares thumbnails.
3. Size estimate runs the native encoder with the selected settings, measures
   each temporary output, then deletes it. Items below 10% savings count at
   their selected size, matching the total shown in the UI even if the file
   size changed after selection. The first calculation uses a placeholder in
   reserved space. Settings changes retain and dim the previous numbers until
   the new result arrives, matching `minimo_video`. Size and savings blocks
   keep their height; counters animate directly between values. Stale
   calculations stop after the current photo and cannot overwrite a newer
   result. Compression is disabled while the estimate refreshes. This adds an
   encoding pass before compression.
4. `PhotoCompressorAdapter` processes photos sequentially.
5. Each item becomes compressed, skipped, or failed.
6. Cancellation invalidates the active run and deletes completed temp outputs.

The plugin has no continuous progress callback. MVP reports the active item at
0%, then 100%; weighted batch progress still advances per completed file.
