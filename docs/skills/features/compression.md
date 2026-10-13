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

1. `StartRoute` opens `CompressRoute` with the selected source. The native
   picker starts there; after selection, the loading indicator stays in the
   photo summary while quality, size, and EXIF settings remain editable.
   Import progress appears in the bottom action. Add and compress are disabled
   until copying finishes. Leaving during import asks for confirmation and
   cancels the picker. An empty initial selection returns to the start screen.
2. `PhotoFileAdapter` returns `PickedPhoto` models. The settings selected
   during import remain in `CompressBloc` when the photos arrive.
3. `CompressBloc` deduplicates by name and size and prepares thumbnails.
4. Size estimate runs the native encoder with the selected settings, measures
   each temporary output, then deletes it. Items below 10% savings count at
   their selected size, matching the total shown in the UI even if the file
   size changed after selection. The first calculation uses a placeholder in
   reserved space. Settings changes retain and dim the previous numbers until
   the new result arrives, matching `minimo_video`. Size and savings blocks
   keep their height; counters animate directly between values. Stale
   calculations stop after the current photo and cannot overwrite a newer
   result. Compression is disabled while the estimate refreshes. This adds an
   encoding pass before compression.
5. `PhotoCompressorAdapter` processes photos sequentially.
6. Each item becomes compressed, skipped, or failed.
7. Cancellation invalidates the active run, waits for the current encoder and
   removes completed, partial and late outputs. Imported sources and previews
   remain available for retry. Encoding failures also remove partial files.
8. A batch retains only explicitly handed-off files inside `picked_photos` and
   `minimo_photo` in the app cache. Native imports use UUID filenames; each
   compression/estimate gets a unique operation directory. Cleanup checks
   canonical paths, file identity metadata and owners, protecting originals,
   symlink targets, reused paths and files still used by another batch.
9. Leaving closes the batch only after import, compression, estimation,
   thumbnail creation, gallery save and share/comparison operations finish.
   Late imports/previews/results are included in cleanup. Recovered picker
   files are handed off into owned cache storage; external originals stay intact. Cold startup clears
   abandoned app cache, including legacy imports/estimates; resuming from the
   background keeps the active batch. Manual clear remains in Settings and
   refuses to delete cache while a batch is active.

The plugin has no continuous progress callback. MVP reports the active item at
0%, then 100%; weighted batch progress still advances per completed file.
