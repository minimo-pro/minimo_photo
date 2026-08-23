import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/app_action_button.dart';
import '../../../../widgets/app_sheet.dart';
import '../../domain/photo_pick_source.dart';

Future<PhotoPickSource?> showPhotoPickSourceSheet(BuildContext context) {
  return showAppContentSheet<PhotoPickSource>(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    child: Builder(
      builder: (sheetContext) {
        final strings = S.of(sheetContext);
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppActionButton(
                  width: double.infinity,
                  label: strings.pickFromGallery,
                  fontSize: 20,
                  onPressed: () =>
                      Navigator.of(sheetContext).pop(PhotoPickSource.gallery),
                ),
                const SizedBox(height: 10),
                AppActionButton(
                  width: double.infinity,
                  label: strings.pickFromFiles,
                  fontSize: 20,
                  onPressed: () =>
                      Navigator.of(sheetContext).pop(PhotoPickSource.files),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
