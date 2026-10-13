import 'dart:io';

import 'package:flutter/gestures.dart';
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
              child: _SplitImageBody(
                result: result,
                originalLabel: strings.originalPhoto,
                compressedLabel: strings.compressedPhoto,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SplitImageBody extends StatefulWidget {
  final CompressedPhoto result;
  final String originalLabel;
  final String compressedLabel;

  const _SplitImageBody({
    required this.result,
    required this.originalLabel,
    required this.compressedLabel,
  });

  @override
  State<_SplitImageBody> createState() => _SplitImageBodyState();
}

class _SplitImageBodyState extends State<_SplitImageBody> {
  static const _handleHitWidth = 48.0;
  static const _labelHideFraction = 0.18;
  static const _semanticStep = 0.05;
  static const _aspectTolerance = 0.02;

  final _transformation = TransformationController();
  late final ImageProvider _originalImage = FileImage(
    File(widget.result.source.path),
  );
  late final ImageProvider? _compressedImage =
      switch (widget.result.result.outputPath) {
        final path? => FileImage(File(path)),
        null => null,
      };
  final _originalSize = _ImageSizeProbe();
  final _compressedSize = _ImageSizeProbe();
  var _split = 0.5;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final configuration = createLocalImageConfiguration(context);
    _originalSize.resolve(_originalImage, configuration, _onSizeResolved);
    if (_compressedImage case final image?) {
      _compressedSize.resolve(image, configuration, _onSizeResolved);
    }
  }

  @override
  void dispose() {
    _originalSize.dispose();
    _compressedSize.dispose();
    _transformation.dispose();
    super.dispose();
  }

  void _onSizeResolved() {
    if (mounted) setState(() {});
  }

  void _setSplit(double value) {
    setState(() => _split = value.clamp(0.0, 1.0));
  }

  String _percent(double value) => '${(value.clamp(0.0, 1.0) * 100).round()}%';

  bool _aspectsMatch(Size a, Size b) {
    final ratioA = a.width / a.height;
    final ratioB = b.width / b.height;
    return (ratioA - ratioB).abs() / ratioA <= _aspectTolerance;
  }

  @override
  Widget build(BuildContext context) {
    final originalSize = _originalSize.size;
    final compressedSize = _compressedSize.size;

    if (originalSize != null &&
        compressedSize != null &&
        !_aspectsMatch(originalSize, compressedSize)) {
      return _buildSideBySide(context);
    }

    if (originalSize == null) return _buildSplit(context, BoxFit.contain);

    return Center(
      child: AspectRatio(
        aspectRatio: originalSize.width / originalSize.height,
        child: _buildSplit(context, BoxFit.fill),
      ),
    );
  }

  Widget _buildSideBySide(BuildContext context) {
    return Row(
      key: const Key('comparison-side-by-side'),
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _image(_originalImage, 'comparison-original', BoxFit.contain),
              Positioned(
                left: 10,
                top: 10,
                child: _PhotoLabel(text: widget.originalLabel),
              ),
            ],
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _image(_compressedImage, 'comparison-compressed', BoxFit.contain),
              Positioned(
                right: 10,
                top: 10,
                child: _PhotoLabel(text: widget.compressedLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _image(ImageProvider? image, String key, BoxFit fit) {
    if (image == null) {
      return _imageError(context, StateError('missing path'), null);
    }
    return Image(
      key: Key(key),
      image: image,
      fit: fit,
      errorBuilder: _imageError,
    );
  }

  Widget _buildSplit(BuildContext context, BoxFit fit) {
    final animationDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 160);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final dividerX = width * _split;

        return Stack(
          fit: StackFit.expand,
          children: [
            InteractiveViewer(
              transformationController: _transformation,
              minScale: 1,
              maxScale: 5,
              child: _image(_originalImage, 'comparison-original', fit),
            ),
            IgnorePointer(
              child: ClipRect(
                clipper: _RevealClipper(_split),
                child: ListenableBuilder(
                  listenable: _transformation,
                  builder: (context, child) =>
                      Transform(transform: _transformation.value, child: child),
                  child: _image(_compressedImage, 'comparison-compressed', fit),
                ),
              ),
            ),
            Positioned(
              left: dividerX - 1,
              top: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  key: const Key('comparison-divider'),
                  width: 2,
                  color: CompressionUiColors.white,
                ),
              ),
            ),
            Positioned(
              left: dividerX - _handleHitWidth / 2,
              top: 0,
              bottom: 0,
              width: _handleHitWidth,
              child: Semantics(
                slider: true,
                value: _percent(_split),
                increasedValue: _percent(_split + _semanticStep),
                decreasedValue: _percent(_split - _semanticStep),
                onIncrease: () => _setSplit(_split + _semanticStep),
                onDecrease: () => _setSplit(_split - _semanticStep),
                child: GestureDetector(
                  key: const Key('comparison-handle'),
                  behavior: HitTestBehavior.opaque,
                  dragStartBehavior: DragStartBehavior.down,
                  onHorizontalDragUpdate: (details) {
                    if (width > 0) _setSplit(_split + details.delta.dx / width);
                  },
                  child: const Center(child: _SplitHandle()),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _split < _labelHideFraction ? 0 : 1,
                  duration: animationDuration,
                  child: _PhotoLabel(text: widget.originalLabel),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _split > 1 - _labelHideFraction ? 0 : 1,
                  duration: animationDuration,
                  child: _PhotoLabel(text: widget.compressedLabel),
                ),
              ),
            ),
          ],
        );
      },
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

class _ImageSizeProbe {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  Size? size;

  void resolve(
    ImageProvider image,
    ImageConfiguration configuration,
    VoidCallback onResolved,
  ) {
    final stream = image.resolve(configuration);
    if (stream.key == _stream?.key) return;
    _detach();
    final listener = ImageStreamListener((info, _) {
      size = Size(info.image.width.toDouble(), info.image.height.toDouble());
      info.dispose();
      onResolved();
    }, onError: (_, _) {});
    _stream = stream..addListener(listener);
    _listener = listener;
  }

  void _detach() {
    if (_listener case final listener?) _stream?.removeListener(listener);
  }

  void dispose() => _detach();
}

class _RevealClipper extends CustomClipper<Rect> {
  final double split;

  const _RevealClipper(this.split);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(size.width * split, 0, size.width, size.height);

  @override
  bool shouldReclip(_RevealClipper oldClipper) => oldClipper.split != split;
}

class _SplitHandle extends StatelessWidget {
  const _SplitHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: CompressionUiColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.28), blurRadius: 6),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chevron_left, size: 16, color: Colors.black),
          Icon(Icons.chevron_right, size: 16, color: Colors.black),
        ],
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
