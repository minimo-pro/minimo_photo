# Architecture

The repository mirrors `minimo_video`: route-driven screens, feature-local
domain/data/presentation layers, BLoC state, shared services and widgets.

```text
lib/
├── features/compression/
│   ├── domain/        settings, selected photo, result models
│   ├── data/          picker/gallery and compressor adapters
│   ├── bloc/          batch state and orchestration
│   └── presentation/  settings, progress, result, comparison UI
├── router/            auto_route configuration
├── screens/           start, onboarding, settings, info, splash
├── services/          preferences, cache, review, changelog
├── widgets/           shared visual primitives
└── l10n/              English and Russian ARB sources
```

## Compression flow

```text
PhotoFileAdapter
  → PickedPhoto[]
  → CompressBloc
  → PhotoCompressorAdapter
  → flutter_image_compress
  → CompressionResult[]
  → Gal / SharePlus
```

`CompressBloc` owns aligned photo, thumbnail, status, and result lists.
Compression is sequential to keep memory predictable. Overall progress is
weighted by source file size.

