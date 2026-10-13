# Screens

| Route | Responsibility |
|---|---|
| `SplashRoute` | Resolve first launch and initial destination |
| `OnboardingRoute` | Explain pick, quality, and private local processing |
| `StartRoute` | Pick photos from gallery or files |
| `CompressRoute` | Import photos, configure during import, process, compare, save, and share |
| `SettingsRoute` | Filename, album, theme, locale, and cache settings |
| `StatsScreen` | Local compressed-photo count and total space saved |
| `InfoRoute` | Project and author links |

`CompressRoute` has three BLoC-driven views:

1. **Ready:** responsive stacked-photo summary, estimated size,
   simple/advanced switch, add-more, and compress actions. Scrolling pins a
   compact size summary beside the back button. After selection, the summary
   shows import progress while settings remain editable.
2. **Processing:** responsive size comparison, weighted progress, remaining
   time, per-photo status list, and hold-to-cancel.
3. **Done:** responsive saved-space result, statuses, compare, save, and share.

The compare sheet shows one uncropped frame: the original fills the frame and
the compressed photo is revealed to the right of a draggable divider (starts
at 50%). Pinch-zoom and pan share one transform, so both sides stay aligned.
The divider is exposed as an accessibility slider, and a label fades out when
its side gets too narrow.

Once both images decode, the frame takes the original's oriented aspect ratio
and both images fill it exactly, absorbing resize rounding. If the aspect
ratios differ by more than 2% (for example, a wrong EXIF rotation), the sheet
shows the photos side by side instead of overlaying misaligned halves.

Shared controls, colors, spacing, sheets, animation, and typography remain the
same as `minimo_video`; media-specific controls live inside compression feature
widgets.
Repeated source-picker requests reuse the active sheet, and the selected source
is returned only after the closing transition finishes.
