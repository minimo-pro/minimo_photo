# Dependencies

| Package | Purpose |
|---|---|
| `flutter_image_compress` | Native image resize and recompression |
| `image_picker` | Multi-select from system photo library |
| `file_picker` | Multi-select supported image files |
| `gal` | Save compressed photos to gallery |
| `share_plus` | Share output files |
| `flutter_bloc` | Compression state orchestration |
| `auto_route` | Typed navigation |
| `shared_preferences` | Persistent settings |
| `path_provider`, `path` | Safe temporary output paths |
| `intl_utils` | English/Russian generated localization |

`flutter_image_compress` is preferred over a custom codec bridge: it provides
native Android/iOS implementations, resize, orientation correction, JPEG/PNG,
and EXIF control behind one small API.

