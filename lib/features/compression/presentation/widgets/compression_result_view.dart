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
    final allFailed = successes.isEmpty;
    final alreadyOptimized = allFailed && state.compressionError == null;
    final originalSize = successes.fold<int>(
      0,
      (sum, item) => sum + (item.result.originalSize ?? item.source.size),
    );
    final saved = (originalSize - state.compressedSize).clamp(0, originalSize);

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 520;
              return Column(
                children: [
                  SelectedPhotosPreview(
                    selectedCount: state.photos.length,
                    thumbnailPaths: state.thumbnailPaths,
                    scale: compact ? 1.32 : 1.72,
                  ),
                  SizedBox(height: compact ? 7 : 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: allFailed
                              ? CompressionUiColors.red
                              : CompressionUiColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox.square(dimension: compact ? 10 : 12),
                      ),
                      const SizedBox(width: 9),
                      Flexible(
                        child: Text(
                          allFailed
                              ? alreadyOptimized
                                    ? strings.alreadyOptimized
                                    : strings.compressionFailed
                              : successes.length == state.results.length
                              ? strings.compressionCompleted
                              : strings.photosCompressed(
                                  successes.length,
                                  state.results.length,
                                ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: compact ? 21 : 25,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? 6 : 8),
                  Text(
                    allFailed
                        ? alreadyOptimized
                              ? strings.alreadyOptimizedDescription
                              : strings.compressionFailedDescription
                        : strings.youSavedSize(
                            Utils.formatSize(saved).toLowerCase(),
                          ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: compact ? 16 : 19,
                      height: compact ? 1.1 : 1,
                    ),
                  ),
                  SizedBox(height: compact ? 8 : 12),
                  Flexible(
                    fit: FlexFit.loose,
                    child: PhotoStatusList(state: state),
                  ),
                  SizedBox(height: compact ? 4 : 8),
                ],
              );
            },
          ),
        ),
        LayoutBuilder(
          builder: (context, _) {
            final compact = MediaQuery.sizeOf(context).height < 720;
            final gap = compact ? 8.0 : 10.0;
            return Column(
              children: [
                SizedBox(height: compact ? 8 : 12),
                Row(
                  children: [
                    Tooltip(
                      message: strings.comparePhotos,
                      child: AppActionButton(
                        width: 47,
                        label: 'VS',
                        fontSize: 16,
                        padding: EdgeInsets.zero,
                        onPressed: allFailed ? null : () => _compare(context),
                      ),
                    ),
                    SizedBox(width: gap),
                    if (!alreadyOptimized)
                      Expanded(
                        child: AppActionButton(
                          width: double.infinity,
                          label: allFailed ? strings.tryAgain : strings.save,
                          loading: state.isSaving,
                          fontSize: 20,
                          variant: AppActionButtonVariant.filled,
                          onPressed: state.isSaving
                              ? null
                              : allFailed
                              ? onTryAgain
                              : () => context.read<CompressBloc>().add(
                                  const CompressResultsSaved(),
                                ),
                        ),
                      )
                    else
                      const Spacer(),
                    if (!allFailed) ...[
                      SizedBox(width: gap),
                      Tooltip(
                        message: strings.shareOrSave,
                        child: AppActionButton(
                          width: 47,
                          icon: AppIcons.share,
                          iconWidth: 22,
                          iconHeight: 22,
                          onPressed: () => _share(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            );
          },
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
