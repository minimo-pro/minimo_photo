import '../domain/compression_result.dart';
import '../domain/compression_settings.dart';
import '../domain/picked_photo.dart';

enum CompressStatus { ready, processing, done }

enum PhotoCompressionStatus { waiting, processing, compressed, skipped, failed }

class CompressedPhoto {
  final PickedPhoto source;
  final CompressionResult result;

  const CompressedPhoto({required this.source, required this.result});
}

class CompressState {
  final CompressStatus status;
  final List<PickedPhoto> photos;
  final List<String?> thumbnailPaths;
  final List<PhotoCompressionStatus> photoStatuses;
  final List<CompressedPhoto> results;
  final int compressionRunId;
  final int processingIndex;
  final double progress;
  final double currentPhotoProgress;
  final Duration elapsed;
  final CompressionSettings settings;
  final int? estimatedSize;
  final bool isEstimating;
  final bool isSaving;
  final bool isSaved;
  final int? savedPhotoCount;
  final int? deletedOriginalCount;
  final Object? saveError;
  final Object? deleteError;
  final Object? metadataError;
  final Object? compressionError;

  const CompressState({
    required this.status,
    required this.photos,
    required this.thumbnailPaths,
    required this.photoStatuses,
    required this.results,
    required this.compressionRunId,
    required this.processingIndex,
    required this.progress,
    required this.currentPhotoProgress,
    required this.elapsed,
    required this.settings,
    this.estimatedSize,
    this.isEstimating = false,
    required this.isSaving,
    this.isSaved = false,
    this.savedPhotoCount,
    this.deletedOriginalCount,
    this.saveError,
    this.deleteError,
    this.metadataError,
    this.compressionError,
  });

  factory CompressState.initial(List<PickedPhoto> photos) => CompressState(
    status: CompressStatus.ready,
    photos: List.unmodifiable(photos),
    thumbnailPaths: List.unmodifiable(
      List<String?>.filled(photos.length, null),
    ),
    photoStatuses: List.unmodifiable(
      List<PhotoCompressionStatus>.filled(
        photos.length,
        PhotoCompressionStatus.waiting,
      ),
    ),
    results: const [],
    compressionRunId: 0,
    processingIndex: 0,
    progress: 0,
    currentPhotoProgress: 0,
    elapsed: Duration.zero,
    settings: const CompressionSettings(),
    isEstimating: photos.isNotEmpty,
    isSaving: false,
  );

  double get displayProgress => progress.clamp(0, 1);
  int get totalOriginalSize => photos.fold(0, (sum, photo) => sum + photo.size);
  List<CompressedPhoto> get successResults =>
      results.where((item) => item.result.success).toList();
  int get compressedSize => successResults.fold(
    0,
    (sum, item) => sum + (item.result.outputSize ?? 0),
  );
  List<String> get successfulOutputPaths => successResults
      .map((item) => item.result.outputPath)
      .whereType<String>()
      .toList();
  bool get usedCodecFallback => false;
  bool get hasUnsavedResults =>
      status == CompressStatus.done && successResults.isNotEmpty && !isSaved;

  CompressState copyWith({
    CompressStatus? status,
    List<PickedPhoto>? photos,
    List<String?>? thumbnailPaths,
    List<PhotoCompressionStatus>? photoStatuses,
    List<CompressedPhoto>? results,
    int? compressionRunId,
    int? processingIndex,
    double? progress,
    double? currentPhotoProgress,
    Duration? elapsed,
    CompressionSettings? settings,
    int? estimatedSize,
    bool? isEstimating,
    bool? isSaving,
    bool? isSaved,
    int? savedPhotoCount,
    int? deletedOriginalCount,
    Object? saveError,
    Object? deleteError,
    Object? metadataError,
    Object? compressionError,
    bool clearSaveNotification = false,
    bool clearCompressionError = false,
    bool clearEstimatedSize = false,
  }) => CompressState(
    status: status ?? this.status,
    photos: List.unmodifiable(photos ?? this.photos),
    thumbnailPaths: List.unmodifiable(thumbnailPaths ?? this.thumbnailPaths),
    photoStatuses: List.unmodifiable(photoStatuses ?? this.photoStatuses),
    results: List.unmodifiable(results ?? this.results),
    compressionRunId: compressionRunId ?? this.compressionRunId,
    processingIndex: processingIndex ?? this.processingIndex,
    progress: progress ?? this.progress,
    currentPhotoProgress: currentPhotoProgress ?? this.currentPhotoProgress,
    elapsed: elapsed ?? this.elapsed,
    settings: settings ?? this.settings,
    estimatedSize: clearEstimatedSize
        ? estimatedSize
        : estimatedSize ?? this.estimatedSize,
    isEstimating: isEstimating ?? this.isEstimating,
    isSaving: isSaving ?? this.isSaving,
    isSaved: isSaved ?? this.isSaved,
    savedPhotoCount: clearSaveNotification
        ? savedPhotoCount
        : savedPhotoCount ?? this.savedPhotoCount,
    deletedOriginalCount: clearSaveNotification
        ? deletedOriginalCount
        : deletedOriginalCount ?? this.deletedOriginalCount,
    saveError: clearSaveNotification ? saveError : saveError ?? this.saveError,
    deleteError: clearSaveNotification
        ? deleteError
        : deleteError ?? this.deleteError,
    metadataError: clearSaveNotification
        ? metadataError
        : metadataError ?? this.metadataError,
    compressionError: clearCompressionError
        ? compressionError
        : compressionError ?? this.compressionError,
  );
}
