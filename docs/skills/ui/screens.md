# Screens

| Route | Responsibility |
|---|---|
| `SplashRoute` | Resolve first launch and initial destination |
| `OnboardingRoute` | Explain pick, quality, and private local processing |
| `StartRoute` | Pick photos from gallery or files |
| `CompressRoute` | Configure, process, compare, save, and share |
| `SettingsRoute` | Filename, album, theme, locale, and cache settings |
| `InfoRoute` | Project and author links |

`CompressRoute` has three BLoC-driven views:

1. **Ready:** stacked photo preview, estimated size, simple/advanced switch,
   add-more and compress actions.
2. **Processing:** weighted progress, per-photo status list, hold-to-cancel.
3. **Done:** saved-space result, statuses, compare, save, and share.

Shared controls, colors, spacing, sheets, animation, and typography remain the
same as `minimo_video`; media-specific controls live inside compression feature
widgets.

