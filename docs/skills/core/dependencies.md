# Dependencies

| Package | Purpose |
|---|---|
| `flutter_image_compress` | Native image resize and recompression |
| `image_picker` | Android gallery multi-select and lost-data recovery |
| `file_picker` | Android selection of supported image files |
| `gal` | Save compressed photos to gallery |
| `share_plus` | Share output files |
| `wakelock_plus` | Keep screen awake during import and compression |
| `flutter_bloc` | Compression state orchestration |
| `auto_route` | Typed navigation |
| `shared_preferences` | Persistent settings |
| `path_provider`, `path` | Safe temporary output paths |
| `intl_utils` | English/Russian generated localization |

`flutter_image_compress` is preferred over a custom codec bridge: it provides
native Android/iOS implementations, resize, orientation correction, JPEG/PNG/HEIC,
and EXIF control behind one small API.
