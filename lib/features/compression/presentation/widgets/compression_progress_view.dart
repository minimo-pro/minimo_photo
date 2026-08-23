import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/utils.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/hold_to_confirm_button.dart';
import '../../bloc/compress_bloc.dart';
import '../../bloc/compress_event.dart';
import '../../bloc/compress_state.dart';
import 'photo_status_list.dart';
import 'selected_photos_preview.dart';

class CompressionProgressView extends StatelessWidget {
  final CompressState state;

  const CompressionProgressView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final percent = (state.displayProgress * 100).round();
    final estimated = state.estimatedSize ?? state.totalOriginalSize;

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 18),
              SelectedPhotosPreview(
                selectedCount: state.photos.length,
                thumbnailPaths: state.thumbnailPaths,
                scale: 1.55,
              ),
              const SizedBox(height: 22),
              Text(
                '${Utils.formatSize(state.totalOriginalSize).toLowerCase()} → ${Utils.formatSize(estimated).toLowerCase()}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: Text('$percent%', style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: state.displayProgress,
                  minHeight: 7,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  color: CompressionUiColors.red,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                strings.photoProgress(
                  state.processingIndex + 1,
                  state.photos.length,
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(child: PhotoStatusList(state: state)),
            ],
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
}
