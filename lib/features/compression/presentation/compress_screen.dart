import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_icons.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.gr.dart';
import '../../../services/app_settings_service.dart';
import '../../../services/review_service.dart';
import '../../../services/screen_awake_service.dart';
import '../../../widgets/app_action_button.dart';
import '../../../widgets/app_snack_bar.dart';
import '../../../widgets/minimo_loader.dart';
import '../bloc/compress_bloc.dart';
import '../bloc/compress_event.dart';
import '../bloc/compress_state.dart';
import '../data/photo_file_adapter.dart';
import '../domain/picked_photo.dart';
import '../domain/compression_settings.dart';
import '../domain/photo_pick_source.dart';
import 'widgets/compression_progress_view.dart';
import 'widgets/compression_result_view.dart';
import 'widgets/compression_settings_view.dart';
import 'widgets/photo_loading_view.dart';
import 'widgets/photo_pick_source_sheet.dart';

@RoutePage()
class CompressScreen extends StatelessWidget {
  final List<PickedPhoto> initialPhotos;
  final CompressionSettings initialSettings;
  final PhotoPickSource? initialPickSource;

  const CompressScreen({
    super.key,
    this.initialPhotos = const [],
    this.initialSettings = const CompressionSettings(),
    this.initialPickSource,
  });

  @override
  Widget build(BuildContext context) {
    if (initialPhotos.isEmpty && initialPickSource == null) {
      return const _StartRedirect();
    }
    return BlocProvider(
      create: (_) => CompressBloc(
        initialPhotos: initialPhotos,
        initialSettings: initialSettings,
      ),
      child: _CompressView(initialPickSource: initialPickSource),
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
  final PhotoPickSource? initialPickSource;

  const _CompressView({this.initialPickSource});

  @override
  State<_CompressView> createState() => _CompressViewState();
}

class _CompressViewState extends State<_CompressView> {
  final _fileAdapter = PhotoFileAdapter();
  bool _loading = false;
  bool _screenAwakeEnabled = false;
  (int, int)? _loadingProgress;
  bool _initialSelectionConfirmed = false;
  bool _leavingDuringImport = false;
  int? _reviewedRun;

  @override
  void initState() {
    super.initState();
    _loading = widget.initialPickSource != null;
    if (widget.initialPickSource case final source?) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => unawaited(_importPhotos(source, initial: true)),
      );
    }
  }

  @override
  void dispose() {
    if (_loading) unawaited(_fileAdapter.cancelPhotoPick());
    unawaited(_setScreenAwake(false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompressBloc, CompressState>(
      listener: (context, state) {
        final strings = S.of(context);
        final partialErrors = [
          if (state.metadataError != null)
            strings.metadataPreservationIncomplete,
          if (state.deleteError != null) strings.originalDeletionFailed,
        ];
        final message = partialErrors.isNotEmpty
            ? strings.savedWithWarnings(partialErrors.join('; '))
            : state.savedPhotoCount != null &&
                  (state.deletedOriginalCount ?? 0) > 0
            ? strings.savedPhotosAndDeletedOriginals(
                state.savedPhotoCount!,
                state.deletedOriginalCount!,
              )
            : state.savedPhotoCount != null
            ? strings.savedPhotosToGallery(state.savedPhotoCount!)
            : state.saveError != null
            ? strings.failedToSave
            : null;
        if (message != null) {
          AppSnackBar.show(
            context,
            message: message,
            type:
                state.deleteError != null ||
                    state.metadataError != null ||
                    state.saveError != null
                ? AppSnackBarType.error
                : AppSnackBarType.success,
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
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop && _loading) unawaited(_confirmLoadingExit());
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
              child: Column(
                children: [
                  if (state.status != CompressStatus.processing) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppActionButton(
                        width: 47,
                        icon: AppIcons.arrowBack,
                        iconWidth: 22,
                        iconHeight: 22,
                        onPressed: () => _loading
                            ? unawaited(_confirmLoadingExit())
                            : context.router.replaceAll([const StartRoute()]),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Expanded(
                    child:
                        state.photos.isEmpty &&
                            widget.initialPickSource != null &&
                            !_initialSelectionConfirmed
                        ? PhotoLoadingView(progress: _loadingProgress)
                        : switch (state.status) {
                            CompressStatus.ready => CompressionSettingsView(
                              state: state,
                              isImporting: _loading,
                              importProgress: _loadingProgress,
                              onAddPhotos: _loading
                                  ? null
                                  : () => unawaited(_pickMore()),
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
    await _importPhotos(source);
  }

  Future<void> _importPhotos(
    PhotoPickSource source, {
    bool initial = false,
  }) async {
    setState(() {
      _loading = true;
      _loadingProgress = null;
    });
    unawaited(_setScreenAwake(AppSettingsService.instance.preventScreenSleep));
    try {
      final photos = await _fileAdapter.pickPhotos(
        source: source,
        onProgress: (done, total) {
          if (mounted) {
            setState(() {
              _loadingProgress = (done, total);
              if (initial && total > 0) _initialSelectionConfirmed = true;
            });
          }
        },
      );
      if (photos.isNotEmpty && mounted) {
        context.read<CompressBloc>().add(CompressPhotosAdded(photos));
      } else if (initial && mounted && !_leavingDuringImport) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(
          context,
          message: S.of(context).failedToPickPhotos,
          type: AppSnackBarType.error,
        );
        if (initial) Navigator.of(context).pop();
      }
    } finally {
      unawaited(_setScreenAwake(false));
      if (mounted) {
        setState(() {
          _loading = false;
          _loadingProgress = null;
        });
      }
    }
  }

  Future<void> _setScreenAwake(bool enabled) async {
    if (enabled == _screenAwakeEnabled) return;
    _screenAwakeEnabled = enabled;
    try {
      await ScreenAwakeService.instance.setEnabled(enabled);
    } catch (_) {
      _screenAwakeEnabled = !enabled;
    }
  }

  Future<void> _confirmLoadingExit() async {
    if (_leavingDuringImport) return;
    final strings = S.of(context);
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(strings.loadingPhotos),
        content: Text(strings.loadingManyPhotosHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              MaterialLocalizations.of(dialogContext).closeButtonLabel,
            ),
          ),
        ],
      ),
    );
    if (leave != true || !mounted) return;
    _leavingDuringImport = true;
    await _fileAdapter.cancelPhotoPick();
    if (mounted) Navigator.of(context).pop();
  }
}
