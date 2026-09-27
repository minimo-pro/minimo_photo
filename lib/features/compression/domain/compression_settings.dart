class CompressionSettings {
  final int quality;
  final int? maxDimension;
  final bool keepExif;

  const CompressionSettings({
    this.quality = 82,
    this.maxDimension = 2560,
    this.keepExif = true,
  });

  CompressionSettings copyWith({
    int? quality,
    Object? maxDimension = _unset,
    bool? keepExif,
  }) {
    return CompressionSettings(
      quality: quality ?? this.quality,
      maxDimension: maxDimension == _unset
          ? this.maxDimension
          : maxDimension as int?,
      keepExif: keepExif ?? this.keepExif,
    );
  }

  SimpleCompressionQuality get simpleQuality {
    if (quality >= 90 && maxDimension == null) {
      return SimpleCompressionQuality.high;
    }
    if (quality >= 82 && maxDimension == 2560) {
      return SimpleCompressionQuality.medium;
    }
    return SimpleCompressionQuality.low;
  }

  factory CompressionSettings.forSimpleQuality(
    SimpleCompressionQuality quality,
  ) => switch (quality) {
    SimpleCompressionQuality.high => const CompressionSettings(
      quality: 90,
      maxDimension: null,
    ),
    SimpleCompressionQuality.medium => const CompressionSettings(),
    SimpleCompressionQuality.low => const CompressionSettings(
      quality: 72,
      maxDimension: 1600,
    ),
  };
}

const _unset = Object();

enum SimpleCompressionQuality { high, medium, low }
