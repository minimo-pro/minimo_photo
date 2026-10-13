<div align="center">


<!-- TODO: Add store links after release. -->
![App Store](https://img.shields.io/badge/App_Store-414141?style=for-the-badge&logo=apple&logoColor=F1F1F1) ![Google Play](https://img.shields.io/badge/Google_Play-414141?style=for-the-badge&logo=googleplay&logoColor=F1F1F1) [![Website](https://img.shields.io/badge/Website-414141?style=for-the-badge)](https://minimo-photo.vercel.app)

minimo (photo) is a free mobile app for shrinking photos directly on your device.
No cloud upload. No subscription. Your photos stay yours.

</div>


![minimo (photo) store preview](docs/images/store-preview.png)

## Features

- Simple quality presets: high, medium, low
- Advanced controls: quality, maximum dimensions, and EXIF metadata
- Batch compression with progress and cancellation
- Before-and-after comparison
- Save and share compressed photos

## Native compression pipeline

```mermaid
flowchart TD
    A[PhotoFileAdapter<br/>loads photos from gallery or files] --> B[CompressBloc<br/>processes photos sequentially]
    B --> C[PhotoCompressorAdapter<br/>applies quality, dimensions and EXIF settings]
    C --> D[flutter_image_compress]
    D --> E{Native platform plugin}

    subgraph Android
        F[Android image APIs]
        F --> G[JPEG or PNG output]
    end

    subgraph iOS
        H[iOS image APIs]
        H --> I[JPEG, PNG or HEIC output]
    end

    E -->|Android| F
    E -->|iOS| H
    G --> J{At least 10% smaller?}
    I --> J
    J -->|Yes| K[Keep temporary result for save or share]
    J -->|No| L[Discard result and keep original]
```

The selected preset sets JPEG quality and a maximum image side. A photo is
skipped when recompression saves less than 10%; this commonly happens when its
dimensions are already below the preset limit. iOS keeps HEIC output for
HEIC/HEIF sources; Android writes them as JPEG.


## How to contribute

[![Contributing](https://img.shields.io/badge/Contributing-Guide-414141?style=for-the-badge)](CONTRIBUTING.md) [![Code of Conduct](https://img.shields.io/badge/Code_of_Conduct-Rules-414141?style=for-the-badge)](CODE_OF_CONDUCT.md)

## Credits

- Photo compression is powered by [flutter_image_compress](https://pub.dev/packages/flutter_image_compress). Respect and thanks to its maintainers and contributors.
- Store screenshot editor: [app-store-screenshots](https://github.com/ParthJadhav/app-store-screenshots) by [Parth Jadhav](https://x.com/parthjadhav8).
- Local metadata workflow: [asc-metadata-sync](https://github.com/rorkai/app-store-connect-cli-skills/tree/main/skills/asc-metadata-sync) and [App Store Connect CLI](https://github.com/rorkai/App-Store-Connect-CLI) by [Rudrank Riyam](https://x.com/rudrank).

## Contacts

[![@khlebobul](https://img.shields.io/badge/@khlebobul-414141?style=for-the-badge&logo=X&logoColor=F1F1F1)](https://x.com/khlebobul) [![Email - khlebobul@gmail.com](https://img.shields.io/badge/Email-khlebobul%40gmail.com-414141?style=for-the-badge&logo=Email&logoColor=F1F1F1)](mailto:khlebobul@gmail.com) [![@khlebobul_dev](https://img.shields.io/badge/%40khlebobul__dev-414141?style=for-the-badge&logo=Telegram&logoColor=F1F1F1)](https://t.me/khlebobul_dev) [![Personal - Website](https://img.shields.io/badge/Personal-Website-414141?style=for-the-badge&logo=Personal&logoColor=F1F1F1)](https://khlebobul.github.io/)

## License

[![LICENCE - MIT](https://img.shields.io/badge/LICENCE-MIT-414141?style=for-the-badge&logo=Licence&logoColor=F1F1F1)](https://github.com/minimo-pro/minimo_photo/blob/main/LICENSE)
