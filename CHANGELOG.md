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