## [1.1.0]

### Added

* Background photo compression on supported iOS and Android devices. Related: [#10](https://github.com/minimo-pro/minimo_photo/issues/10), [#11](https://github.com/minimo-pro/minimo_photo/issues/11).
* Add a hand-drawn Threads icon linking to [@khlebobul](https://www.threads.com/@khlebobul) from About.
* Background imports from the gallery and Files, with progress and cancellation. [#17](https://github.com/minimo-pro/minimo_photo/issues/17).

Background runtime depends on the OS. Recovery after relaunch and Android 13+ notification permission prompts are not included.

### Changed

* Refresh onboarding with animated video cards, staggered fade-and-rise transitions, swipe-linked progress segments, and trailing icons on Next and Get started. Reduced motion keeps components static.

### Fixed

* Settle Android import cancellation even when a provider blocks file reads, and finish queued commands for stopped background operations.
* Keep update dialogs compatible with the app’s current Flutter localization setup.

## [1.0.8]

### Added

* Share your compressed-photo count and space saved as text from the statistics screen through the system share sheet. [#14](https://github.com/minimo-pro/minimo_photo/issues/14).

### Changed

* Replace `in_app_review` with `rate_my_app` for app rating prompts. [#16](https://github.com/minimo-pro/minimo_photo/issues/16).
* Enable Android Gradle Plugin's built-in Kotlin support (`android.builtInKotlin=true`).

## [1.0.7]

### Fixed

* Fix interrupted batch saving when replacing original photos on iOS: trust the successful Photos transaction instead of fetching the newly created photo again, and preserve its favorite status in the same transaction.

## [1.0.6]

### Fixed

* Save compressed photos when replacing originals on iOS even if some originals are unavailable; report deletion and metadata warnings when both occur.

### Improved

* Increase the contrast of secondary text in the light theme.

## [1.0.5]

### Added

* Suggest minimo (video) after successful photo compressions in a dismissible top card, with its own prompt counter and three-month cooldown.

### Changed

* Match the video app's confirmation dialog when leaving with unsaved compressed photos or photos still loading.

## [1.0.4]

### Added

* Add an optional setting to remove location from compressed photos while keeping other supported metadata. [#5](https://github.com/minimo-pro/minimo_photo/issues/5).

### Fixed

* Let iOS users choose to save a compressed copy, then confirm deletion of the original.
* Show language names in lowercase in Settings.
* Keep three-digit photo counts on one line inside the selection badge.

## [1.0.3]

### Added

* Use minimo in 13 languages, with a language picker in Settings

## [1.0.2]

### Added

* Adjust photo quality and maximum dimension with sliders in advanced mode
* Show a reminder to keep the app open while compressing photos
* Select more photos at once from the gallery or files

## [1.0.1]

### Added

* Share minimo with friends from the about screen

### Improved

* Save compressed photos as new gallery items more reliably

## [1.0.0]

### Added

* Initial release
