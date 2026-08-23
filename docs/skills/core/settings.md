# Settings

Persistent app settings live in `AppSettingsService`.

| Key | Default | Meaning |
|---|---:|---|
| `add_minimo_prefix` | `true` | Prefix output name with `minimo_` |
| `save_photos_to_album` | `false` | Save to the `Minimo` album |
| `language_code` | system | UI locale override |
| `dark_theme` | system | Theme override |

Compression settings are per batch and not persisted: `quality`, optional
`maxDimension`, and `keepExif`.

Temporary compressed outputs use the `minimo_photo` cache directory. Cache
cleanup never touches gallery photos.
