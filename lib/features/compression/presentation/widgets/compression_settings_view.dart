import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/utils.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/animated_asset_checkbox.dart';
import '../../../../widgets/app_option_picker.dart';
import '../../../../widgets/app_settings_section.dart';
import '../../../../widgets/faded_scroll_view.dart';
import '../../../../widgets/pressable.dart';
import '../../../../widgets/rolling_counter_text.dart';
import '../../../../widgets/spring_tab_content.dart';
import '../../bloc/compress_bloc.dart';
import '../../bloc/compress_event.dart';
import '../../bloc/compress_state.dart';
import '../../domain/compression_settings.dart';
import 'compression_bottom_actions.dart';
import 'compression_mode_switch.dart';
import 'selected_photos_summary.dart';
import 'simple_quality_card.dart';

class CompressionSettingsView extends StatefulWidget {
  final CompressState state;
  final VoidCallback onAddPhotos;

  const CompressionSettingsView({
    super.key,
    required this.state,
    required this.onAddPhotos,
  });

  @override
  State<CompressionSettingsView> createState() =>
      _CompressionSettingsViewState();
}

class _CompressionSettingsViewState extends State<CompressionSettingsView> {
  CompressionOptionsMode _mode = CompressionOptionsMode.simple;
  final _sizeRowKey = GlobalKey();
  bool _showPinnedSummary = false;
  bool _pinnedSummaryUpdateScheduled = false;

  @override
  void initState() {
    super.initState();
    _schedulePinnedSummaryUpdate();
  }

  @override
  void didUpdateWidget(covariant CompressionSettingsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _schedulePinnedSummaryUpdate();
  }

  bool _onScroll(ScrollNotification notification) {
    _schedulePinnedSummaryUpdate();
    return false;
  }

  void _schedulePinnedSummaryUpdate() {
    if (_pinnedSummaryUpdateScheduled) return;
    _pinnedSummaryUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pinnedSummaryUpdateScheduled = false;
      if (mounted) _updatePinnedSummary();
    });
  }

  void _updatePinnedSummary() {
    final viewBox = context.findRenderObject() as RenderBox?;
    final rowBox = _sizeRowKey.currentContext?.findRenderObject() as RenderBox?;
    if (viewBox == null || rowBox == null || !rowBox.attached) return;

    final viewTop = viewBox.localToGlobal(Offset.zero).dy;
    final rowBottom = rowBox.localToGlobal(Offset(0, rowBox.size.height)).dy;
    final show = rowBottom <= viewTop + 4;
    if (show == _showPinnedSummary || !mounted) return;
    setState(() => _showPinnedSummary = show);
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final estimatedSize = state.estimatedSize;
    final savingsPercent = estimatedSize == null || state.totalOriginalSize == 0
        ? null
        : ((1 - estimatedSize / state.totalOriginalSize) * 100)
              .clamp(0, 99)
              .round();

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 640;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: _onScroll,
                    child: FadedScrollView(
                      fadeExtent: 0.08,
                      padding: EdgeInsets.symmetric(vertical: compact ? 4 : 6),
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: compact ? 185 : 200,
                            ),
                            child: SelectedPhotosSummary(
                              sizeRowKey: _sizeRowKey,
                              selectedCount: state.photos.length,
                              thumbnailPaths: state.thumbnailPaths,
                              originalSize: state.totalOriginalSize,
                              estimatedSize: estimatedSize,
                              isEstimating: state.isEstimating,
                              savingsPercent: savingsPercent,
                              compact: compact,
                            ),
                          ),
                          SizedBox(height: compact ? 14 : 22),
                          CompressionModeSwitch(
                            value: _mode,
                            onChanged: (value) => setState(() => _mode = value),
                          ),
                          SizedBox(height: compact ? 14 : 24),
                          SpringTabContent(
                            value: _mode,
                            child: _mode == CompressionOptionsMode.simple
                                ? _SimpleOptions(state: state, compact: compact)
                                : _AdvancedOptions(
                                    state: state,
                                    compact: compact,
                                  ),
                          ),
                          if (_mode == CompressionOptionsMode.advanced)
                            const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -55,
                    left: 55,
                    right: 8,
                    height: 47,
                    child: IgnorePointer(
                      child: AnimatedOpacity(
                        opacity: _showPinnedSummary ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        child: AnimatedSlide(
                          offset: _showPinnedSummary
                              ? Offset.zero
                              : const Offset(0, -0.35),
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOutCubic,
                          child: AnimatedScale(
                            scale: _showPinnedSummary ? 1 : 0.96,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOutCubic,
                            child: _PinnedSizeSummary(
                              originalSize: state.totalOriginalSize,
                              estimatedSize: estimatedSize,
                              isEstimating: state.isEstimating,
                              savingsPercent: savingsPercent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        CompressionBottomActions(
          onAdd: widget.onAddPhotos,
          onCompress: state.isEstimating || savingsPercent == 0
              ? null
              : () => context.read<CompressBloc>().add(const CompressStarted()),
        ),
      ],
    );
  }
}

class _PinnedSizeSummary extends StatelessWidget {
  final int originalSize;
  final int? estimatedSize;
  final int? savingsPercent;
  final bool isEstimating;

  const _PinnedSizeSummary({
    required this.originalSize,
    required this.estimatedSize,
    required this.savingsPercent,
    required this.isEstimating,
  });

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Utils.formatSize(originalSize).toLowerCase(),
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 20,
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset(
                              AppIcons.arrowForward,
                              width: 20,
                              height: 17,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                            child: AnimatedOpacity(
                              opacity: isEstimating ? 0.45 : 1,
                              duration: const Duration(milliseconds: 180),
                              child: estimatedSize == null
                                  ? Center(
                                      child: Text(
                                        isEstimating ? '…' : '—',
                                        style: const TextStyle(
                                          color: CompressionUiColors.red,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : RollingCounterText(
                                      value: estimatedSize!,
                                      formatter: (value) => Utils.formatSize(
                                        value.toInt(),
                                      ).toLowerCase(),
                                      style: const TextStyle(
                                        color: CompressionUiColors.red,
                                        fontSize: 20,
                                        height: 1,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: savingsPercent == null
                        ? const Text('—')
                        : savingsPercent == 0
                        ? Text(
                            strings.noSavingsHint,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: CompressionUiColors.red,
                              fontSize: 13,
                              height: 1.15,
                            ),
                          )
                        : RollingCounterText(
                            value: savingsPercent!,
                            formatter: (value) => '${value.toInt()}%',
                            style: const TextStyle(
                              color: CompressionUiColors.red,
                              fontSize: 17,
                              height: 1,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SimpleOptions extends StatelessWidget {
  final CompressState state;
  final bool compact;

  const _SimpleOptions({required this.state, required this.compact});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final selected = state.settings.simpleQuality;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.quality,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: compact ? 24 : 29,
            height: 1,
          ),
        ),
        SizedBox(height: compact ? 17 : 31),
        SimpleQualityCard(
          selected: selected == SimpleCompressionQuality.high,
          quality: SimpleCompressionQuality.high,
          title: strings.high,
          subtitle: strings.photoQualityHighDescription,
          onSelected: _onSelected(context),
          compact: compact,
        ),
        SizedBox(height: compact ? 12 : 21),
        SimpleQualityCard(
          selected: selected == SimpleCompressionQuality.medium,
          quality: SimpleCompressionQuality.medium,
          title: strings.medium,
          subtitle: strings.photoQualityMediumDescription,
          onSelected: _onSelected(context),
          compact: compact,
        ),
        SizedBox(height: compact ? 12 : 21),
        SimpleQualityCard(
          selected: selected == SimpleCompressionQuality.low,
          quality: SimpleCompressionQuality.low,
          title: strings.low,
          subtitle: strings.photoQualityLowDescription,
          onSelected: _onSelected(context),
          compact: compact,
        ),
      ],
    );
  }

  ValueChanged<SimpleCompressionQuality> _onSelected(BuildContext context) {
    return (quality) =>
        context.read<CompressBloc>().add(CompressSimpleQualityChanged(quality));
  }
}

class _AdvancedOptions extends StatelessWidget {
  final CompressState state;
  final bool compact;

  const _AdvancedOptions({required this.state, required this.compact});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final settings = state.settings;

    void update(CompressionSettings value) =>
        context.read<CompressBloc>().add(CompressSettingsChanged(value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSettingsSection(
          title: strings.quality,
          description: strings.photoQualityDescription,
          child: AppOptionPicker<int>(
            value: settings.quality,
            options: const [
              AppOption(value: 95, label: '95%'),
              AppOption(value: 90, label: '90%'),
              AppOption(value: 82, label: '82%'),
              AppOption(value: 72, label: '72%'),
              AppOption(value: 60, label: '60%'),
            ],
            onChanged: (quality) => update(settings.copyWith(quality: quality)),
          ),
        ),
        SizedBox(height: compact ? 18 : 28),
        AppSettingsSection(
          title: strings.maximumDimension,
          description: strings.maximumDimensionDescription,
          child: AppOptionPicker<int?>(
            value: settings.maxDimension,
            options: [
              AppOption(value: null, label: strings.original),
              const AppOption(value: 3840, label: '3840 px'),
              const AppOption(value: 2560, label: '2560 px'),
              const AppOption(value: 1920, label: '1920 px'),
              const AppOption(value: 1600, label: '1600 px'),
              const AppOption(value: 1280, label: '1280 px'),
            ],
            onChanged: (dimension) =>
                update(settings.copyWith(maxDimension: dimension)),
          ),
        ),
        SizedBox(height: compact ? 18 : 28),
        AppSettingsSection(
          title: strings.keepMetadata,
          description: strings.keepMetadataDescription,
          child: Pressable(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  update(settings.copyWith(keepExif: !settings.keepExif)),
              child: Row(
                children: [
                  Expanded(child: Text(strings.keepExif)),
                  IgnorePointer(
                    child: AnimatedAssetCheckbox(
                      value: settings.keepExif,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
