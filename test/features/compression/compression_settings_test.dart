import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';

void main() {
  test('presets trade quality for dimensions', () {
    final high = CompressionSettings.forSimpleQuality(
      SimpleCompressionQuality.high,
    );
    final medium = CompressionSettings.forSimpleQuality(
      SimpleCompressionQuality.medium,
    );
    final low = CompressionSettings.forSimpleQuality(
      SimpleCompressionQuality.low,
    );

    expect(high.maxDimension, isNull);
    expect(medium.maxDimension, 2560);
    expect(low.maxDimension, 1600);
    expect(high.quality, greaterThan(low.quality));
  });

  test('compression output must save at least ten percent', () {
    expect(PhotoCompressorAdapter.isUsefulCompression(1000, 900), isTrue);
    expect(PhotoCompressorAdapter.isUsefulCompression(1000, 901), isFalse);
  });
}
