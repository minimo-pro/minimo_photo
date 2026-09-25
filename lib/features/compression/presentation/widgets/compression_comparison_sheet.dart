import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/utils.dart';
import '../../../../theme/app_colors.dart';
import '../../bloc/compress_state.dart';

const _sheetHorizontalPadding = 18.0;

class CompressionComparisonSheet extends StatefulWidget {
  final List<CompressedPhoto> results;

  const CompressionComparisonSheet({super.key, required this.results});

  @override
  State<CompressionComparisonSheet> createState() =>
      _CompressionComparisonSheetState();
}

class _CompressionComparisonSheetState
    extends State<CompressionComparisonSheet> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final result = widget.results[_selectedIndex];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          _sheetHorizontalPadding,
          10,
          _sheetHorizontalPadding,
          18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              strings.comparePhotos,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                height: 1,
              ),
            ),
            if (widget.results.length > 1) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: OverflowBox(
                  minWidth: MediaQuery.sizeOf(context).width,
                  maxWidth: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.center,
                  child: SizedBox.expand(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _sheetHorizontalPadding,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.results.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final selected = index == _selectedIndex;
                        return ChoiceChip(
                          selected: selected,
                          showCheckmark: false,
                          label: SizedBox(
                            width: 150,
                            child: Text(
                              widget.results[index].source.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: selected
                                ? CompressionUiColors.white
                                : Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                          ),
                          selectedColor: CompressionUiColors.red,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          side: BorderSide(
                            color: selected
                                ? CompressionUiColors.red
                                : Theme.of(context).colorScheme.outline,
                          ),
                          onSelected: (_) =>
                              setState(() => _selectedIndex = index),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 14),
            Flexible(
              child: _ComparisonImage(key: ValueKey(result), result: result),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonImage extends StatelessWidget {
  final CompressedPhoto result;

  const _ComparisonImage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final originalSize = result.result.originalSize ?? result.source.size;
    final compressedSize = result.result.outputSize ?? 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Utils.formatSize(originalSize),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              AppIcons.arrowForward,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              Utils.formatSize(compressedSize),
              style: const TextStyle(
                color: CompressionUiColors.green,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ColoredBox(
              color: Colors.black,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: _SplitImageBody(
                  result: result,
                  originalLabel: strings.originalPhoto,
                  compressedLabel: strings.compressedPhoto,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SplitImageBody extends StatelessWidget {
  final CompressedPhoto result;
  final String originalLabel;
  final String compressedLabel;

  const _SplitImageBody({
    required this.result,
    required this.originalLabel,
    required this.compressedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final compressedPath = result.result.outputPath;

    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRect(
                child: Image.file(
                  File(result.source.path),
                  key: const Key('comparison-original'),
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                  errorBuilder: _imageError,
                ),
              ),
            ),
            Expanded(
              child: ClipRect(
                child: compressedPath == null
                    ? _imageError(context, StateError('missing path'), null)
                    : Image.file(
                        File(compressedPath),
                        key: const Key('comparison-compressed'),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                        errorBuilder: _imageError,
                      ),
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            key: const Key('comparison-divider'),
            width: 2,
            color: CompressionUiColors.white,
          ),
        ),
        Positioned(left: 10, top: 10, child: _PhotoLabel(text: originalLabel)),
        Positioned(
          right: 10,
          top: 10,
          child: _PhotoLabel(text: compressedLabel),
        ),
      ],
    );
  }

  Widget _imageError(BuildContext context, Object error, StackTrace? stack) {
    return Center(
      child: Icon(
        Icons.broken_image_outlined,
        color: CompressionUiColors.white.withValues(alpha: 0.78),
        size: 42,
      ),
    );
  }
}

class _PhotoLabel extends StatelessWidget {
  final String text;

  const _PhotoLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            color: CompressionUiColors.white,
            fontSize: 13,
            height: 1,
          ),
        ),
      ),
    );
  }
}
