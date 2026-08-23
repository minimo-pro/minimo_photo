import '../domain/compression_settings.dart';
import '../domain/picked_photo.dart';

abstract class CompressEvent {
  const CompressEvent();
}

class CompressSimpleQualityChanged extends CompressEvent {
  final SimpleCompressionQuality quality;

  const CompressSimpleQualityChanged(this.quality);
}

class CompressThumbnailsRequested extends CompressEvent {
  const CompressThumbnailsRequested();
}

class CompressEstimateRequested extends CompressEvent {
  const CompressEstimateRequested();
}

class CompressPhotosAdded extends CompressEvent {
  final List<PickedPhoto> photos;

  const CompressPhotosAdded(this.photos);
}

class CompressSettingsChanged extends CompressEvent {
  final CompressionSettings settings;

  const CompressSettingsChanged(this.settings);
}

class CompressStarted extends CompressEvent {
  const CompressStarted();
}

class CompressProgressChanged extends CompressEvent {
  final int runId;
  final double progress;
  final double currentPhotoProgress;
  final Duration elapsed;

  const CompressProgressChanged({
    required this.runId,
    required this.progress,
    required this.currentPhotoProgress,
    required this.elapsed,
  });
}

class CompressCancelled extends CompressEvent {
  const CompressCancelled();
}

class CompressBackgrounded extends CompressEvent {
  const CompressBackgrounded();
}

class CompressForegroundResumed extends CompressEvent {
  const CompressForegroundResumed();
}

class CompressResultsSaved extends CompressEvent {
  const CompressResultsSaved();
}

class CompressMessagesCleared extends CompressEvent {
  const CompressMessagesCleared();
}
