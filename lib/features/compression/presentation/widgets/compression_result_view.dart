import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../constants/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/utils.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_action_button.dart';
import '../../../../widgets/app_sheet.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../bloc/compress_bloc.dart';
import '../../bloc/compress_event.dart';
import '../../bloc/compress_state.dart';
import 'compression_comparison_sheet.dart';
import 'photo_status_list.dart';
import 'selected_photos_preview.dart';

class CompressionResultView extends StatelessWidget {
  final CompressState state;
  final VoidCallback onTryAgain;

  const CompressionResultView({
    super.key,
    required this.state,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final successes = state.successResults;
    final failed = successes.isEmpty;
    final compressionFailed = failed && state.compressionError != null;
    final originalSize = successes.fold<int>(
      0,
      (sum, item) => sum + (item.result.originalSize ?? item.source.size),
    );
    final saved = (originalSize - state.compressedSize).clamp(0, originalSize);

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              SelectedPhotosPreview(
                selectedCount: state.photos.length,
                thumbnailPaths: state.thumbnailPaths,
                scale: 1.55,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: failed
                          ? CompressionUiColors.red
                          : CompressionUiColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(dimension: 12),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    failed
                        ? compressionFailed
                              ? strings.compressionFailed
                              : strings.alreadyOptimized
                        : strings.compressionCompleted,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                failed
                    ? compressionFailed
                          ? strings.compressionFailedDescription
                          : strings.alreadyOptimizedDescription
                    : strings.youSavedSize(
                        Utils.formatSize(saved).toLowerCase(),
                      ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(child: PhotoStatusList(state: state)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            AppActionButton(
              width: 47,
              label: 'VS',
              onPressed: failed ? null : () => _compare(context),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppActionButton(
                width: double.infinity,
                label: failed ? strings.tryAgain : strings.save,
                variant: AppActionButtonVariant.filled,
                onPressed: state.isSaving
                    ? null
                    : failed
                    ? onTryAgain
                    : () => context.read<CompressBloc>().add(
                        const CompressResultsSaved(),
                      ),
              ),
            ),
            if (!failed) ...[
              const SizedBox(width: 10),
              AppActionButton(
                width: 47,
                icon: AppIcons.share,
                iconWidth: 22,
                iconHeight: 22,
                onPressed: () => _share(context),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _compare(BuildContext context) {
    showAppSheet(
      context: context,
      heightFraction: 0.86,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: CompressionComparisonSheet(results: state.successResults),
    );
  }

  Future<void> _share(BuildContext context) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      await SharePlus.instance.share(
        ShareParams(
          files: state.successfulOutputPaths
              .map((path) => XFile(path, mimeType: 'image/*'))
              .toList(),
          sharePositionOrigin: box == null
              ? null
              : box.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      AppSnackBar.show(
        context,
        message: S.of(context).failedToShare,
        type: AppSnackBarType.error,
      );
    }
  }
}
