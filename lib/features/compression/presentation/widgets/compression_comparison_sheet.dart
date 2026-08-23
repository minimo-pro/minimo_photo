import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/app_action_button.dart';
import '../../bloc/compress_state.dart';

class CompressionComparisonSheet extends StatefulWidget {
  final List<CompressedPhoto> results;

  const CompressionComparisonSheet({super.key, required this.results});

  @override
  State<CompressionComparisonSheet> createState() =>
      _CompressionComparisonSheetState();
}

class _CompressionComparisonSheetState
    extends State<CompressionComparisonSheet> {
  var _index = 0;
  var _showCompressed = true;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final result = widget.results[_index];
    final path = _showCompressed
        ? result.result.outputPath!
        : result.source.path;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
        child: Column(
          children: [
            Text(
              result.source.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: ColoredBox(
                  color: Colors.black,
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 5,
                    child: Center(child: Image.file(File(path))),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppActionButton(
                    width: double.infinity,
                    label: strings.originalPhoto,
                    variant: !_showCompressed
                        ? AppActionButtonVariant.filled
                        : AppActionButtonVariant.text,
                    onPressed: () => setState(() => _showCompressed = false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppActionButton(
                    width: double.infinity,
                    label: strings.compressedPhoto,
                    variant: _showCompressed
                        ? AppActionButtonVariant.filled
                        : AppActionButtonVariant.text,
                    onPressed: () => setState(() => _showCompressed = true),
                  ),
                ),
              ],
            ),
            if (widget.results.length > 1) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _index == 0
                        ? null
                        : () => setState(() => _index--),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text('${_index + 1} / ${widget.results.length}'),
                  IconButton(
                    onPressed: _index == widget.results.length - 1
                        ? null
                        : () => setState(() => _index++),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
