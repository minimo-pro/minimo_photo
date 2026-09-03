import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/utils.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/hold_to_confirm_button.dart';
import '../../bloc/compress_bloc.dart';
import '../../bloc/compress_event.dart';
import '../../bloc/compress_state.dart';
import '../utils/compression_estimate.dart';
import 'photo_status_list.dart';
import 'selected_photos_preview.dart';

class CompressionProgressView extends StatelessWidget {
  final CompressState state;

  const CompressionProgressView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final progress = state.displayProgress;
    final percent = (progress * 100).round();

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 620;
              return Column(
                children: [
                  SizedBox(height: compact ? 10 : 24),
                  SelectedPhotosPreview(
                    selectedCount: state.photos.length,
                    thumbnailPaths: state.thumbnailPaths,
                    scale: compact ? 1.34 : 1.72,
                  ),
                  SizedBox(height: compact ? 16 : 30),
                  _ProgressSizeComparison(state: state, compact: compact),
                  SizedBox(height: compact ? 16 : 28),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$percent%',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: compact ? 16 : 18,
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      key: ValueKey(state.compressionRunId),
                      value: progress,
                      minHeight: compact ? 6 : 7,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      color: CompressionUiColors.red,
                    ),
                  ),
                  SizedBox(height: compact ? 9 : 13),
                  Text(
                    '${strings.photoProgress(state.processingIndex + 1, state.photos.length)} · ${_remainingTimeLabel(strings, state)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: compact ? 15 : 17,
                      height: 1.05,
                    ),
                  ),
                  SizedBox(height: compact ? 10 : 16),
                  Flexible(
                    fit: FlexFit.loose,
                    child: PhotoStatusList(state: state),
                  ),
                  SizedBox(height: compact ? 12 : 24),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        HoldToConfirmButton(
          label: strings.cancel,
          enabled: true,
          actionStyle: true,
          onTap: () => AppSnackBar.show(
            context,
            message: strings.holdToCancelCompression,
          ),
          onCompleted: () async {
            context.read<CompressBloc>().add(const CompressCancelled());
            AppSnackBar.show(
              context,
              message: strings.compressionCancelled,
              type: AppSnackBarType.success,
            );
          },
        ),
      ],
    );
  }

  String _remainingTimeLabel(S strings, CompressState state) {
    final progress = state.displayProgress;
    if (progress < 0.02 || state.elapsed.inSeconds < 1) {
      return strings.estimatingTimeRemaining;
    }

    final totalMilliseconds = state.elapsed.inMilliseconds / progress;
    final remaining = Duration(
      milliseconds: (totalMilliseconds - state.elapsed.inMilliseconds)
          .round()
          .clamp(0, 86400000)
          .toInt(),
    );
    if (remaining.inSeconds < 60) {
      return strings.secondsRemaining(remaining.inSeconds.clamp(1, 59));
    }
    return strings.minutesRemaining(
      (remaining.inSeconds / 60).ceil().clamp(1, 1440),
    );
  }
}

class _ProgressSizeComparison extends StatelessWidget {
  final CompressState state;
  final bool compact;

  const _ProgressSizeComparison({required this.state, required this.compact});

  @override
  Widget build(BuildContext context) {
    final estimatedSize =
        state.estimatedSize ??
        CompressionEstimate.compressedSize(
          originalSize: state.totalOriginalSize,
          settings: state.settings,
        );

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                Utils.formatSize(state.totalOriginalSize).toLowerCase(),
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: compact ? 23 : 28,
                  height: 1,
                ),
              ),
            ),
          ),
          SizedBox(width: compact ? 10 : 13),
          SizedBox(
            width: compact ? 24 : 29,
            height: compact ? 20 : 24,
            child: SvgPicture.asset(
              AppIcons.arrowForward,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: compact ? 10 : 13),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Utils.formatSize(estimatedSize).toLowerCase(),
                maxLines: 1,
                style: TextStyle(
                  color: CompressionUiColors.red,
                  fontSize: compact ? 23 : 28,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
