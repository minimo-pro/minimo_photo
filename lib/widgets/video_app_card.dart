import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_icons.dart';
import '../generated/l10n.dart';
import '../theme/app_theme.dart';
import 'pressable.dart';

class VideoAppCard extends StatelessWidget {
  const VideoAppCard({super.key});

  static final _appStoreUrl = Uri.parse(
    'https://apps.apple.com/us/app/minimo-video/id6787456951',
  );
  static final _googlePlayUrl = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.khlebobul.minimo_video',
  );

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Pressable(
      child: Material(
        color: theme.frameBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () => launchUrl(
            Platform.isIOS ? _appStoreUrl : _googlePlayUrl,
            mode: LaunchMode.externalApplication,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logo/video.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'minimo (video)',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        S.of(context).videoAppDescription,
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 15,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.arrowForward,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    theme.iconColor,
                    BlendMode.srcIn,
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
