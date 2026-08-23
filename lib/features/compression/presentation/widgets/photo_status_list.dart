import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/faded_scroll_view.dart';
import '../../bloc/compress_state.dart';

class PhotoStatusList extends StatelessWidget {
  final CompressState state;

  const PhotoStatusList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: FadedScrollView(
          fadeExtent: 0.12,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              for (var index = 0; index < state.photos.length; index++) ...[
                if (index > 0) const SizedBox(height: 10),
                _PhotoStatusRow(state: state, index: index),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoStatusRow extends StatelessWidget {
  final CompressState state;
  final int index;

  const _PhotoStatusRow({required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    final status = index < state.photoStatuses.length
        ? state.photoStatuses[index]
        : PhotoCompressionStatus.waiting;

    return Row(
      children: [
        Expanded(
          child: Text(
            state.photos[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 15,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: 10),
        _StatusIndicator(status: status, progress: state.currentPhotoProgress),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final PhotoCompressionStatus status;
  final double progress;

  const _StatusIndicator({required this.status, required this.progress});

  @override
  Widget build(BuildContext context) {
    if (status == PhotoCompressionStatus.processing) {
      return SizedBox(
        key: const ValueKey('photo-status-processing'),
        width: 34,
        child: Text(
          '${(progress * 100).round()}%',
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: CompressionUiColors.red,
            fontSize: 13,
            height: 1,
          ),
        ),
      );
    }

    return DecoratedBox(
      key: ValueKey('photo-status-${status.name}'),
      decoration: BoxDecoration(color: _color(status), shape: BoxShape.circle),
      child: const SizedBox.square(dimension: 8),
    );
  }
}

Color _color(PhotoCompressionStatus status) {
  return switch (status) {
    PhotoCompressionStatus.waiting => CompressionUiColors.grey,
    PhotoCompressionStatus.processing => CompressionUiColors.red,
    PhotoCompressionStatus.compressed => CompressionUiColors.green,
    PhotoCompressionStatus.skipped => CompressionUiColors.grey,
    PhotoCompressionStatus.failed => CompressionUiColors.red,
  };
}
