import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/data/photo_file_adapter.dart';

void main() {
  test('maps native photo capabilities and metadata', () {
    final photos = PhotoFileAdapter.mapPlatformFiles([
      {
        'path': '/tmp/photo.jpg',
        'name': 'photo.jpg',
        'size': 42,
        'sourceIdentifier': 'asset-1',
        'canPreserveMetadata': true,
        'canDeleteOriginal': true,
        'captureDate': '2026-09-26T10:00:00Z',
        'latitude': 55.75,
        'longitude': 37.62,
      },
    ]);

    final photo = photos.single;
    expect(photo.sourceIdentifier, 'asset-1');
    expect(photo.canPreserveMetadata, isTrue);
    expect(photo.canDeleteOriginal, isTrue);
    expect(photo.captureDate, '2026-09-26T10:00:00Z');
    expect(photo.latitude, 55.75);
    expect(photo.longitude, 37.62);
  });
}
