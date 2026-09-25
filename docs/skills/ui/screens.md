# Screens

| Route | Responsibility |
|---|---|
| `SplashRoute` | Resolve first launch and initial destination |
| `OnboardingRoute` | Explain pick, quality, and private local processing |
| `StartRoute` | Pick photos from gallery or files |
| `CompressRoute` | Configure, process, compare, save, and share |
| `SettingsRoute` | Filename, album, theme, locale, and cache settings |
| `StatsScreen` | Local compressed-photo count and total space saved |
| `InfoRoute` | Project and author links |

`CompressRoute` has three BLoC-driven views:

1. **Ready:** responsive stacked-photo summary, estimated size,
   simple/advanced switch, add-more, and compress actions. Scrolling pins a
   compact size summary beside the back button.
2. **Processing:** responsive size comparison, weighted progress, remaining
   time, per-photo status list, and hold-to-cancel.
3. **Done:** responsive saved-space result, statuses, compare, save, and share.

Shared controls, colors, spacing, sheets, animation, and typography remain the
same as `minimo_video`; media-specific controls live inside compression feature
widgets.
Repeated source-picker requests reuse the active sheet, and the selected source
is returned only after the closing transition finishes.
