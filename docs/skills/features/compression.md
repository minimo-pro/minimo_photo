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

JPEG-compatible sources are written as JPEG. PNG sources stay PNG. The native
plugin corrects orientation. An output is accepted only when it is at least
10% smaller; otherwise the temporary file is deleted and the item is marked
skipped.

## Batch lifecycle

1. `PhotoFileAdapter` returns `PickedPhoto` models.
2. `CompressBloc` deduplicates by name and size and prepares thumbnails.
3. Size estimate uses a documented preset heuristic.
4. `PhotoCompressorAdapter` processes photos sequentially.
5. Each item becomes compressed, skipped, or failed.
6. Cancellation invalidates the active run and deletes completed temp outputs.

The plugin has no continuous progress callback. MVP reports the active item at
0%, then 100%; weighted batch progress still advances per completed file.

