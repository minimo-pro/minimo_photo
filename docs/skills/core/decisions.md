# Decisions

## Keep UI inside app

UI is not extracted into a package for MVP. Shared widgets already isolate the
visual language while feature screens remain free to evolve independently.
Extract only after a second app proves stable, identical public components.

## Native image package

Use `flutter_image_compress` instead of FFmpeg or custom platform channels.
The package covers current JPEG/PNG/HEIC resize and compression needs with less
app code and smaller platform surface. HEIC output is used on iOS; Android keeps
the JPEG path because HEIC encoding and metadata support vary by device.

## Sequential batch processing

Process one photo at a time. This bounds memory use and makes cancellation,
status, and cleanup deterministic.

## Preserve originals

Outputs live in app temporary storage until the user explicitly saves or
shares them. The app never overwrites a source photo. On iOS, the user may
explicitly request deletion of originals after replacements are saved.
