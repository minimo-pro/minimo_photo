# Testing

Automated checks:

```bash
flutter analyze
flutter test
```

Unit tests cover preset/estimate behavior, minimum useful savings, cache
cleanup, local statistics, shared controls, result statuses, and picker sheet
behavior including duplicate-request protection.

Before release, verify on physical Android and iOS devices:

- gallery and files selection, including cancellation
- JPEG, PNG, WebP, HEIC/HEIF sources supported by each platform
- portrait orientation and EXIF behavior
- all three presets and advanced dimensions
- batch cancel leaves no partial output offered for saving
- gallery save and share sheet
- screen stays awake during picker import and compression when enabled, then sleeps normally afterward
- low-storage and permission-denied errors
