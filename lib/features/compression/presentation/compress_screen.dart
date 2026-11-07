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
import '../../../theme/app_theme.dart';
import '../../../widgets/app_action_button.dart';
import '../../../widgets/app_snack_bar.dart';
import '../../../widgets/minimo_loader.dart';
import '../../../widgets/video_app_card.dart';
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
  int? _promptRequestedForRunId;
  final _videoPrompt = OverlayPortalController();
  Timer? _videoPromptTimer;
  bool _confirmingExit = false;
  bool _exitAllowed = false;

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
    _videoPromptTimer?.cancel();
    if (_loading) unawaited(_fileAdapter.cancelPhotoPick());
    unawaited(_setScreenAwake(false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _videoPrompt,
      overlayChildBuilder: _buildVideoPrompt,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
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
        unawaited(_promptAfterSuccessfulCompression(state));
      },
      builder: (context, state) => PopScope(
        canPop: _exitAllowed,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) unawaited(_exit());
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
                        onPressed: () => unawaited(_exit()),
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

  Widget _buildVideoPrompt(BuildContext context) {
    return Positioned(
      left: 18,
      right: 18,
      top: MediaQuery.paddingOf(context).top + 14,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -24 * (1 - value)),
            child: child,
          ),
        ),
        child: Semantics(
          container: true,
          liveRegion: true,
          child: Material(
            color: AppTheme.of(context).frameBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).videoAppPromptTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Tooltip(
                          message: MaterialLocalizations.of(
                            context,
                          ).closeButtonTooltip,
                          child: AppActionButton(
                            width: 40,
                            height: 40,
                            icon: AppIcons.close,
                            variant: AppActionButtonVariant.text,
                            onPressed: _dismissVideoPrompt,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VideoAppCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dismissVideoPrompt() {
    _videoPromptTimer?.cancel();
    _videoPrompt.hide();
  }

  Future<void> _promptAfterSuccessfulCompression(CompressState state) async {
    if (state.status != CompressStatus.done ||
        _promptRequestedForRunId == state.compressionRunId) {
      return;
    }

    _promptRequestedForRunId = state.compressionRunId;
    late final CompressionPrompt prompt;
    try {
      prompt = await ReviewService.instance.onSuccessfulConversions(
        state.successfulOutputPaths.length,
      );
    } catch (_) {
      return;
    }
    if (prompt != CompressionPrompt.videoApp ||
        !mounted ||
        context.read<CompressBloc>().state.compressionRunId !=
            state.compressionRunId) {
      return;
    }
    _videoPrompt.show();
    _videoPromptTimer?.cancel();
    _videoPromptTimer = Timer(const Duration(seconds: 10), _dismissVideoPrompt);
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
      final bloc = context.read<CompressBloc>();
      final photos = await bloc.useFiles(() async {
        final picked = await _fileAdapter.pickPhotos(
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
        await bloc.retainPhotos(picked);
        return picked;
      });
      if (photos.isNotEmpty && mounted && !_leavingDuringImport) {
        context.read<CompressBloc>().add(CompressPhotosAdded(photos));
      } else if (initial && mounted && !_leavingDuringImport) {
        unawaited(_exit(confirm: false));
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(
          context,
          message: S.of(context).failedToPickPhotos,
          type: AppSnackBarType.error,
        );
        if (initial) unawaited(_exit(confirm: false));
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

  Future<void> _exit({bool confirm = true}) async {
    if (_confirmingExit || _exitAllowed) return;
    final bloc = context.read<CompressBloc>();
    if (bloc.state.status == CompressStatus.processing) return;
    _confirmingExit = true;
    try {
      if (confirm && (_loading || bloc.state.hasUnsavedResults)) {
        final strings = S.of(context);
        final leave = await showDialog<bool>(
          context: context,
          builder: (_) => _ExitConfirmationDialog(
            title: _loading
                ? strings.loadingPhotos
                : strings.unsavedResultsTitle,
            message: _loading
                ? strings.loadingManyPhotosHint
                : strings.unsavedResultsExit,
            leaveLabel: _loading ? strings.leave : strings.leaveWithoutSaving,
          ),
        );
        if (leave != true || !mounted) return;
      }
      _leavingDuringImport = true;
      if (_loading) await _fileAdapter.cancelPhotoPick();
      try {
        await bloc.finishBatch();
      } catch (_) {
        if (mounted) {
          AppSnackBar.show(
            context,
            message: S.of(context).cacheClearFailed,
            type: AppSnackBarType.error,
          );
        }
      }
      if (!mounted) return;
      setState(() => _exitAllowed = true);
      await WidgetsBinding.instance.endOfFrame;
      if (mounted) Navigator.of(context).pop();
    } finally {
      _confirmingExit = false;
    }
  }
}

class _ExitConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String leaveLabel;

  const _ExitConfirmationDialog({
    required this.title,
    required this.message,
    required this.leaveLabel,
  });

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 26),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 390),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: colors.outline),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 32,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 26, 26, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colors.onSurface,
                    fontSize: 30,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 17,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                AppActionButton(
                  width: double.infinity,
                  height: 54,
                  label: strings.stay,
                  fontSize: 22,
                  variant: AppActionButtonVariant.filled,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                const SizedBox(height: 10),
                AppActionButton(
                  width: double.infinity,
                  height: 54,
                  label: leaveLabel,
                  fontSize: 18,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
