# Screens

| Route | Responsibility |
|---|---|
| `SplashRoute` | Resolve first launch and initial destination |
| `OnboardingRoute` | Explain pick, quality, and private local processing |
| `StartRoute` | Pick photos from gallery or files |
| `CompressRoute` | Import photos, configure during import, process, compare, save, and share |
| `SettingsRoute` | Filename, album, theme, locale, and cache settings |
| `StatsScreen` | Local compressed-photo count, total space saved, and text sharing |
| `InfoRoute` | Project and author links |

Onboarding illustrates selecting photos, choosing a quality preset, and saving
a private local copy. Photo cards, captions, and text fade and rise with swipe
progress. Three progress segments fill as the user advances. The primary button
stays below the scrollable content on small screens and with enlarged text.
Reduced motion makes the illustrations static and Next switch pages immediately.
Skip and Get started save onboarding completion and the current changelog
version before opening `StartRoute`.

The About screen uses labeled buttons with arrows for project and author links.
Report a bug opens a prefilled email and copies the address if no mail app is
available. The Threads button opens the profile `@khlebobul` through the
external URL launcher.

The statistics screen shares a localized text summary of both counters through
the system share sheet. It includes the app name, a call to try the app, and
the project website link, with no photo attachments.

`CompressRoute` has three BLoC-driven views:

1. **Ready:** responsive stacked-photo summary, estimated size,
   simple/advanced switch, add-more, and compress actions. Scrolling pins a
   compact size summary beside the back button. After selection, the summary
   shows import progress while settings remain editable.
2. **Processing:** responsive size comparison, weighted progress, remaining
   time, per-photo status list, and hold-to-cancel.
3. **Done:** responsive saved-space result, statuses, compare, save, and share.

After two successful photo conversions, the result screen requests a rating.
After three successful conversions, it can suggest minimo (video) using the
same card as Settings and About. Each prompt has its own conversion counter
and three-month cooldown. Only one prompt appears per compression run. The
video suggestion slides in at the top without a border or shadow, closes
automatically after ten seconds or with its close button, and disappears
when the compression screen closes. After seven compression runs with at
least one successful photo each, the same banner can ask for a GitHub star.
It appears once, on a run when neither earlier prompt takes priority.

Leaving with unsaved compressed photos or while photos are loading uses the
same confirmation dialog as `minimo_video`, with a primary Stay action and an
explicit leave action.

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
