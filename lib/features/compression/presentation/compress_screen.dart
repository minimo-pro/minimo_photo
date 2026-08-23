import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_icons.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.gr.dart';
import '../../../services/review_service.dart';
import '../../../widgets/app_action_button.dart';
import '../../../widgets/app_snack_bar.dart';
import '../../../widgets/minimo_loader.dart';
import '../bloc/compress_bloc.dart';
import '../bloc/compress_event.dart';
import '../bloc/compress_state.dart';
import '../data/photo_file_adapter.dart';
import '../domain/picked_photo.dart';
import 'widgets/compression_progress_view.dart';
import 'widgets/compression_result_view.dart';
import 'widgets/compression_settings_view.dart';
import 'widgets/photo_loading_view.dart';
import 'widgets/photo_pick_source_sheet.dart';

@RoutePage()
class CompressScreen extends StatelessWidget {
  final List<PickedPhoto> initialPhotos;

  const CompressScreen({super.key, this.initialPhotos = const []});

  @override
  Widget build(BuildContext context) {
    if (initialPhotos.isEmpty) return const _StartRedirect();
    return BlocProvider(
      create: (_) => CompressBloc(initialPhotos: initialPhotos),
      child: const _CompressView(),
    );
  }
}

class _StartRedirect extends StatefulWidget {
  const _StartRedirect();

  @override
  State<_StartRedirect> createState() => _StartRedirectState();
}

class _StartRedirectState extends State<_StartRedirect> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.router.replaceAll([const StartRoute()]);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: MinimoLoader(semanticsLabel: S.of(context).loadingPhotos),
    ),
  );
}

class _CompressView extends StatefulWidget {
  const _CompressView();

  @override
  State<_CompressView> createState() => _CompressViewState();
}

class _CompressViewState extends State<_CompressView> {
  final _fileAdapter = PhotoFileAdapter();
  bool _loading = false;
  (int, int)? _loadingProgress;
  int? _reviewedRun;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompressBloc, CompressState>(
      listener: (context, state) {
        if (state.savedPhotoCount != null || state.saveError != null) {
          AppSnackBar.show(
            context,
            message: state.savedPhotoCount != null
                ? S.of(context).savedPhotosToGallery(state.savedPhotoCount!)
                : S.of(context).failedToSave,
            type: state.saveError == null
                ? AppSnackBarType.success
                : AppSnackBarType.error,
          );
          context.read<CompressBloc>().add(const CompressMessagesCleared());
        }
        if (state.status == CompressStatus.done &&
            _reviewedRun != state.compressionRunId) {
          _reviewedRun = state.compressionRunId;
          unawaited(
            ReviewService.instance.onSuccessfulConversions(
              state.successfulOutputPaths.length,
            ),
          );
        }
      },
      builder: (context, state) => PopScope(
        canPop: state.status != CompressStatus.processing && !_loading,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
              child: Column(
                children: [
                  if (!_loading &&
                      state.status != CompressStatus.processing) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppActionButton(
                        width: 47,
                        icon: AppIcons.arrowBack,
                        variant: AppActionButtonVariant.text,
                        onPressed: () =>
                            context.router.replaceAll([const StartRoute()]),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Expanded(
                    child: _loading
                        ? PhotoLoadingView(progress: _loadingProgress)
                        : switch (state.status) {
                            CompressStatus.ready => CompressionSettingsView(
                              state: state,
                              onAddPhotos: () => unawaited(_pickMore()),
                            ),
                            CompressStatus.processing =>
                              CompressionProgressView(state: state),
                            CompressStatus.done => CompressionResultView(
                              state: state,
                              onTryAgain: () => context
                                  .read<CompressBloc>()
                                  .add(const CompressStarted()),
                            ),
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickMore() async {
    final source = await showPhotoPickSourceSheet(context);
    if (source == null || !mounted) return;
    setState(() => _loading = true);
    try {
      final photos = await _fileAdapter.pickPhotos(
        source: source,
        onProgress: (done, total) {
          if (mounted) setState(() => _loadingProgress = (done, total));
        },
      );
      if (mounted) {
        context.read<CompressBloc>().add(CompressPhotosAdded(photos));
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(
          context,
          message: S.of(context).failedToPickPhotos,
          type: AppSnackBarType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadingProgress = null;
        });
      }
    }
  }
}
