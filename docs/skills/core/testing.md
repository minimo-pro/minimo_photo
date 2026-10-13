# Testing

Automated checks:

```bash
flutter analyze
flutter test
```

Unit tests cover preset/estimate behavior, minimum useful savings, cache
cleanup (ownership, symlinks, reused paths, delayed operations), local statistics, shared controls, result statuses, and picker sheet
behavior including duplicate-request protection.

Before release, verify on physical Android and iOS devices:

- gallery and files selection, including cancellation
- JPEG, PNG, WebP, HEIC/HEIF sources supported by each platform
- portrait orientation and EXIF behavior
- all three presets and advanced dimensions
- batch cancel leaves no completed/partial output; imported photos can be retried
- saved and unsaved results survive background/resume; exit confirmation works
- exit during import/save/share waits, then removes only that batch’s cache
- gallery save and share sheet
- screen stays awake during picker import and compression when enabled, then sleeps normally afterward
- low-storage and permission-denied errors
