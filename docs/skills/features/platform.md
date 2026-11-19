# Platform Integration

Compression uses a package plugin. Photo selection uses the
`minimo_photo/photos` method channel in `SceneDelegate.swift` on iOS and
`MainActivity.kt` on Android. iOS gallery replacement uses the same channel.

## Selection

- iOS gallery: `PHPickerViewController`, no app-imposed selection limit; selected files are
  copied into the app cache with their source identifiers and available metadata
- iOS files: `UIDocumentPickerViewController`, selected files copied to cache
- Android gallery: system photo picker on Android 13+ (up to its system limit),
  content picker on older versions; no app-imposed selection limit
- Android files: system document picker for images

The start and add-more flows share `PhotoFileAdapter` and the same source
sheet. Both native pickers send `pickProgress` after selection and as files are
copied, so the settings screen stays interactive during cloud downloads and
large-file copies. Empty initial selection returns to the start screen;
empty add-more selection leaves current settings and photos unchanged.

## Compression

`flutter_image_compress` calls native Android/iOS image APIs. Output files are
created in unique operation directories under temporary `minimo_photo` storage.
Native imported copies use UUID names under `picked_photos` on both platforms.

## Gallery

`gal.putImage` saves successful output files. On iOS, the native channel can
also save a replacement with source date/location metadata and, after a
successful save, request deletion of selected originals. Android declares
legacy write permission only through API 29; modern Android and iOS use system
photo-library authorization. iOS usage strings live in `Runner/Info.plist`.

### Save diagnostics

Run `rtk proxy flutter run -d <device-id>` with a physical device attached and
repeat the failed save. Filter console output by `[photo-save]`.
`CompressBloc` logs batch options, item progress, retries, elapsed time and
errors with stack traces. iOS logs each save with its own UUID: input extension,
readability/size, free storage, Photos authorization before/after the request,
album creation and Photos commit (including the favorite flag).
Authorization values: 0 = not determined, 1 = restricted, 2 = denied,
3 = authorized, 4 = limited; access level 1 = add only, 2 = read/write.
Photos commit failures include NSError domain/code and underlying error details
in the Flutter exception. A successful commit confirms saving without fetching
the newly created asset again. Diagnostics do not
explicitly print image contents, source identifiers or location coordinates;
system error descriptions may contain local paths. Logs stay in the local
device/development console; there is no upload or in-app log storage.

## External photo imports

- Android accepts `ACTION_SEND` and `ACTION_SEND_MULTIPLE` for images, copies up to 50 URIs into app cache, then opens `CompressRoute`.
- iOS Share Extension and the `Compress Photos in minimo` Shortcut stage files in the `group.com.khlebobul.minimoPhoto` App Group inbox. The app copies a complete request into `picked_photos` before opening `CompressRoute`; the Shortcut quality preset becomes the initial setting.
- Share Extension finishes after staging. Open minimo from the Home Screen to continue.

## Screen awake

When `prevent_screen_sleep` is enabled, `wakelock_plus` keeps the display awake while photos import through the picker and while a batch compresses. The app releases it on completion, cancellation, or leaving the import screen.

## Background picker imports

Gallery and Files imports acquire background runtime after selection, for both
initial selection and add-more. iOS 26+ requests CPU-only continued processing
with a unique `.import.*` identifier and system progress/cancellation. Older iOS,
inactive submission, or denied admission falls back to a finite UIKit background
task; expiration cancels the import. Gallery provider loads are cancelled and
remaining document copies are skipped; completed copies are removed when the
in-flight callbacks/copy finish.

Android uses `PhotoProcessingService`, a `dataSync` foreground service with a partial
wake lock, progress notification and Cancel action. Cancellation and system
timeout stop copying between buffer reads and remove that batch's cached files.
If foreground service startup is denied, the selection fails safely.

Runtime is released on completion or cancellation. Force quit does not resume
imports. External Share/Shortcut inbox consumption is unchanged.

## Background compression

`BackgroundCompressionService` requests native runtime before `CompressBloc`
starts the sequential batch. iOS 26+ reuses `BackgroundPhotoTask` with a separate
CPU-only `.compression.*` identifier. Android reuses `PhotoProcessingService`
with the `mediaProcessing` foreground type on API 35+, and `dataSync` on older
Android. Both platforms expose system progress and cancellation; Android holds
a partial wake lock independently of the screen-awake setting.

The warning to keep the app open appears only without a runtime grant. If runtime
is unavailable, the current photo can finish or be suspended by the OS, and the
batch waits before starting another photo until the app resumes. No completed
results are discarded or recompressed during this fallback. System cancellation
or expiration uses the normal batch-cancel path: wait for the active encoder,
remove completed and late output files, preserve selected sources for retry.
Runtime is released after finalization, on cancel, and on exit. Force quit does
not resume compression. Gallery saving remains a separate user action.
