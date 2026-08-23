import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/animated_asset_checkbox.dart';
import '../../../../widgets/app_option_picker.dart';
import '../../../../widgets/app_settings_section.dart';
import '../../../../widgets/faded_scroll_view.dart';
import '../../../../widgets/pressable.dart';
import '../../bloc/compress_bloc.dart';
import '../../bloc/compress_event.dart';
import '../../bloc/compress_state.dart';
import '../../domain/compression_settings.dart';
import '../utils/compression_estimate.dart';
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

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final estimatedSize =
        state.estimatedSize ??
        CompressionEstimate.compressedSize(
          originalSize: state.totalOriginalSize,
          settings: state.settings,
        );
    final savings = state.totalOriginalSize == 0
        ? 0
        : ((1 - estimatedSize / state.totalOriginalSize) * 100)
              .clamp(0, 99)
              .round();

    return Column(
      children: [
        Expanded(
          child: FadedScrollView(
            fadeExtent: 0.08,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                SelectedPhotosSummary(
                  selectedCount: state.photos.length,
                  thumbnailPaths: state.thumbnailPaths,
                  originalSize: state.totalOriginalSize,
                  estimatedSize: estimatedSize,
                  savingsPercent: savings,
                ),
                const SizedBox(height: 22),
                CompressionModeSwitch(
                  value: _mode,
                  onChanged: (value) => setState(() => _mode = value),
                ),
                const SizedBox(height: 22),
                if (_mode == CompressionOptionsMode.simple)
                  _SimpleOptions(state: state)
                else
                  _AdvancedOptions(state: state),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        CompressionBottomActions(
          onAdd: widget.onAddPhotos,
          onCompress: () =>
              context.read<CompressBloc>().add(const CompressStarted()),
        ),
      ],
    );
  }
}

class _SimpleOptions extends StatelessWidget {
  final CompressState state;

  const _SimpleOptions({required this.state});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final selected = state.settings.simpleQuality;
    final bloc = context.read<CompressBloc>();

    return Column(
      children: [
        SimpleQualityCard(
          selected: selected == SimpleCompressionQuality.high,
          quality: SimpleCompressionQuality.high,
          title: strings.high,
          subtitle: strings.photoQualityHighDescription,
          onSelected: (value) => bloc.add(CompressSimpleQualityChanged(value)),
        ),
        const SizedBox(height: 10),
        SimpleQualityCard(
          selected: selected == SimpleCompressionQuality.medium,
          quality: SimpleCompressionQuality.medium,
          title: strings.medium,
          subtitle: strings.photoQualityMediumDescription,
          onSelected: (value) => bloc.add(CompressSimpleQualityChanged(value)),
        ),
        const SizedBox(height: 10),
        SimpleQualityCard(
          selected: selected == SimpleCompressionQuality.low,
          quality: SimpleCompressionQuality.low,
          title: strings.low,
          subtitle: strings.photoQualityLowDescription,
          onSelected: (value) => bloc.add(CompressSimpleQualityChanged(value)),
        ),
      ],
    );
  }
}

class _AdvancedOptions extends StatelessWidget {
  final CompressState state;

  const _AdvancedOptions({required this.state});

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
        const SizedBox(height: 24),
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
        const SizedBox(height: 24),
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
