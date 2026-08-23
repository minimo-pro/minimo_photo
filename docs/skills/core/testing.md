# Testing

Automated checks:

```bash
flutter analyze
flutter test
```

Unit tests cover preset/estimate behavior, minimum useful savings, cache
cleanup, shared controls, result statuses, and picker sheet behavior.

Before release, verify on physical Android and iOS devices:

- gallery and files selection, including cancellation
- JPEG, PNG, WebP, HEIC/HEIF sources supported by each platform
- portrait orientation and EXIF behavior
- all three presets and advanced dimensions
- batch cancel leaves no partial output offered for saving
- gallery save and share sheet
- low-storage and permission-denied errors

