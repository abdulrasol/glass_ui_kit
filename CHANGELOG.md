## 0.1.1

- **Added `GlassStepper`** — multi-step progress indicator with glass or flat styling. Integrated from `simple_step_checkout` package.
- **Added `GlassStepperController`** — navigation controller for `GlassStepper` (same API as `SimpleCheckoutStepperController`).
- **Added `GlassStepperStyle` enum** — `glass` (GlassContainer surfaces) or `flat` (colored circles with token defaults).
- **Added `GlassStepperDirection` enum** — `horizontal` or `vertical`.
- **Added `StepperWidgetBuilder` typedef** — replaces `StepWidgetBuilder`.
- Renamed `doneColor` → `activeColor`, `unDoneColor` → `inactiveColor`, `stepIndexColor` → `stepNumberColor`.
- Fixed `hroizatalPadding` typo → `horizontalPadding`.

## 0.1.0

- Initial release.
- **Theme system:** `GlassThemeTokens` ThemeExtension with `greenTheme()`, `fromSeed()`, `copyWith()`, and `lerp()`.
- **Surface widgets:** `GlassContainer`, `AnimatedGlassContainer`, `PulsingGlassImage`.
- **Scaffold:** `BaseWidget` with `builder`/`child` assert, `transparentAppBar=true`, `overlayBuilder`, `backgroundBuilder`, `drawer`, `endDrawer`.
- **AppBar:** `GlassAppBar.build()` static method (no GetX dependency).
- **Buttons:** `Button`, `SubmitButton`, `CircularIconButton`, `CircularBackButton`.
- **Form inputs:** `TextInputField`, `DropdownField<T>`, `CheckboxField`, `TimePickerField`, `NumberInputFieldWithButtons`, `GlassSegmentedChipsPicker<T>`.
- **Indicators:** `GlassPulsingIndicator` (no Lottie dependency).
- **Constants:** `GlassDefaults` with shared spacing/sizing tokens.
- **Enums:** `GlassSurfaceVariant`, `GlassButtonVariant`.