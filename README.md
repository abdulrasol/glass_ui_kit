# glass_ui_kit

A glassmorphism UI component library for Flutter with theme-driven design tokens. Zero external dependencies beyond Flutter — no GetX, no Lottie, no lock-in.

## Features

- **Theme-driven colors** — every color reads from `GlassThemeTokens` via `ThemeExtension`. Change one seed color and the entire glass palette follows.
- **`GlassThemeTokens.fromSeed(Color)`** — generate a full 24-token palette algorithmically from any single color.
- **`GlassThemeTokens.greenTheme()`** — drop-in replacement for the original mazraeati palette.
- **4 glass surface variants** — `primary`, `secondary`, `circular`, `appBar` — each with its own blur, gradient, and highlight system.
- **`BaseWidget`** — full-page scaffold with gradient background, glow decorations, glass AppBar, and composition slots (`overlayBuilder`, `backgroundBuilder`, `drawer`).
- **`BaseWidget.builder`** — provides `topPadding` for `ListView`/`CustomScrollView` without fighting `SafeArea`.
- **16 grok widgets** — `GlassContainer`, `Button`, `TextInputField`, `DropdownField`, `CheckboxField`, `TimePickerField`, `NumberInputFieldWithButtons`, `GlassSegmentedChipsPicker`, and more.
- **`transparentAppBar` defaults to `true`** — matches the glass aesthetic where the AppBar is translucent by default.
- **Smooth animations** — press-scale on buttons, pulsing glass containers, shimmer-loading images.

## Installation

### From Git

```yaml
dependencies:
  glass_ui_kit:
    git:
      url: https://github.com/abdulrasol/glass_ui_kit.git
```

## Quick Start

### 1. Provide `GlassThemeTokens` in your app theme

```dart
import 'package:flutter/material.dart';
import 'package:glass_ui_kit/glass_ui_kit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Glass App',
      theme: ThemeData(
        useMaterial3: true,
        extensions: [
          GlassThemeTokens.greenTheme(brightness: Brightness.light),
        ],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: [
          GlassThemeTokens.greenTheme(brightness: Brightness.dark),
        ],
      ),
      home: const HomeScreen(),
    );
  }
}
```

### 2. Use `BaseWidget` as your screen scaffold

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: 'My Garden',
      // Use builder for scrollable content — you get topPadding
      builder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.only(top: topPadding),
          children: [
            TextInputField(label: 'Plant name', controller: _ctrl),
            // ...
          ],
        );
      },
      // Or use child for fixed content — SafeArea is handled for you
      // child: Center(child: Text('Hello')),
    );
  }
}
```

### 3. Use any glass widget

```dart
GlassContainer(
  variant: GlassSurfaceVariant.primary,
  borderRadius: 20,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Hello, Glass!'),
  ),
)
```

## Theming

### `GlassThemeTokens` — the single source of truth

All widgets read colors and blur values from `GlassThemeTokens.of(context)`. This class is a `ThemeExtension`, so it participates in Flutter's theme system and animates during light/dark transitions.

| Factory | Purpose |
|---|---|
| `GlassThemeTokens.greenTheme(brightness:)` | Exact original mazraeati palette — drop-in replacement |
| `GlassThemeTokens.fromSeed(Color, brightness:)` | Auto-generate a full palette from any color using HSL rotation |
| `GlassThemeTokens({...})` | Full custom constructor — specify every token yourself |
| `tokens.copyWith(...)` | Override specific tokens without rebuilding everything |
| `tokens.lerp(other, t)` | Animated transition between two token sets |

### Using `fromSeed`

```dart
// Blue glass aesthetic
extensions: [
  GlassThemeTokens.fromSeed(Colors.blue, brightness: Brightness.light),
]

// Deep orange glass aesthetic
extensions: [
  GlassThemeTokens.fromSeed(const Color(0xFFFF6D00), brightness: Brightness.dark),
]
```

### Token catalog

| Token | Description |
|---|---|
| `primaryColor` | Primary accent color used for cursors, checkboxes, chip selection |
| `backgroundStart/Middle/End` | 3-stop gradient for screen backgrounds |
| `backgroundGlowPrimary/Secondary` | Radial gradient glow overlay colors |
| `contentPrimary/Secondary/Inverse` | Text/content colors |
| `dropdownBackgroundColor` | Background for dropdown menus |
| `shadowColor` | Shadow color used in glass surface styles |
| `subtleOutlineColor` | Border/outline color for secondary glass surfaces |
| `primarySurface1/2/3` | 3-stop gradient colors for `GlassSurfaceVariant.primary` |
| `secondarySurface1/2/3` | 3-stop gradient colors for `GlassSurfaceVariant.secondary` |
| `circularSurface1/2` | 2-stop gradient colors for `GlassSurfaceVariant.circular` |
| `appBarSurface1/2` | 2-stop gradient colors for `GlassSurfaceVariant.appBar` |
| `primaryBlurSigma` | Backdrop blur intensity for primary surfaces |
| `secondaryBlurSigma` | Backdrop blur intensity for secondary surfaces |
| `circularBlurSigma` | Backdrop blur intensity for circular buttons |
| `appBarBlurSigma` | Backdrop blur intensity for app bar |

## Widgets

### Surface & Layout

| Widget | Description |
|---|---|
| `GlassContainer` | Frosted-glass backdrop-blur container with 4 surface variants |
| `AnimatedGlassContainer` | Pulsing scale animation wrapping `GlassContainer` |
| `PulsingGlassImage` | Network image with shimmer glass loading and error fallback |
| `BaseWidget` | Full-page scaffold with gradient, glow, glass AppBar, and composition slots |
| `GlassAppBar` | Static `build()` method producing a glass-styled `PreferredSizeWidget` |

### Buttons

| Widget | Description |
|---|---|
| `Button` | Press-animated glass button with loading state |
| `SubmitButton` | Async button that auto-manages loading/error states |
| `CircularIconButton` | Circular glass button for icon actions |
| `CircularBackButton` | RTL-aware back navigation button (defaults to `Navigator.pop`) |

### Form Inputs

| Widget | Description |
|---|---|
| `TextInputField` | Glass-styled text field with label, icon, validator |
| `DropdownField<T>` | Glass dropdown with typed items |
| `CheckboxField` | Glass-styled checkbox with label |
| `TimePickerField` | Glass time picker trigger |
| `NumberInputFieldWithButtons` | Numeric stepper with +/- buttons |
| `GlassSegmentedChipsPicker<T>` | Horizontal segmented chip selector |

### Indicators

| Widget | Description |
|---|---|
| `GlassPulsingIndicator` | Pulsing glass loading spinner (no Lottie dependency) |

### Navigation

| Widget | Description |
|---|---|
| `GlassStepper` | Multi-step progress indicator with glass or flat styling |
| `GlassStepperController` | Navigation controller for `GlassStepper` |

## BaseWidget API Reference

```dart
BaseWidget(
  title: 'Screen Title',         // AppBar title (optional)
  child: myWidget,                // Simple content — SafeArea handled
  // OR:
  builder: (context, topPadding) {  // Scrollable content — you get topPadding
    return ListView(
      padding: EdgeInsets.only(top: topPadding),
      children: [...],
    );
  },
  actions: const [IconButton(...)], // AppBar actions
  withBack: true,                  // Show back button (default: true)
  transparentAppBar: true,         // Glass AppBar (default: true)
  showAppBar: true,                // Show/hide AppBar (default: true)
  centerTitle: false,              // Center the title (default: false)
  overlayBuilder: (context) => ConnectivityBar(),  // Overlay slot (e.g., status bar)
  backgroundBuilder: (context) => myGradient,       // Custom background (default: glass gradient)
  onBack: () => customBack,        // Override back navigation
  drawer: myDrawer,               // Scaffold drawer
  endDrawer: myEndDrawer,          // Scaffold endDrawer
  bottomNavigationBar: myNavBar,   // Bottom navigation
  floatingActionButton: myFab,     // FAB
  bodyPadding: EdgeInsets.all(16), // Custom body padding (child mode only)
  scaffoldBackgroundColor: Colors.black, // Scaffold background color
)
```

> **Important:** Either `child` or `builder` must be provided — never both or neither. An `assert` enforces this at compile time.

## GlassStepper — Multi-Step Progress

A step indicator with two visual modes:

### Glass mode (default)

Step circles use `GlassContainer` surfaces — frosted-glass blur with gradient colors from `GlassThemeTokens`.

```dart
final controller = GlassStepperController(
  steps: 4,
  stepsList: const ['Cart', 'Address', 'Payment', 'Confirm'],
);

GlassStepper(
  controller: controller,
  style: GlassStepperStyle.glass,  // default
)
```

### Flat mode

Classic colored circles. Colors default from `GlassThemeTokens` but can be overridden via constructor params.

```dart
GlassStepper(
  controller: controller,
  style: GlassStepperStyle.flat,
  activeColor: Colors.green,     // override
  inactiveColor: Colors.grey,
)
```

### Vertical direction

```dart
GlassStepper(
  controller: controller,
  direction: GlassStepperDirection.vertical,
  stepHeight: 40,
  horizontalPadding: 100,
)
```

### Custom step builder

```dart
GlassStepper(
  controller: controller,
  stepBuilder: (index, isDone, isActive) => Icon(
    isDone ? Icons.check_circle : Icons.radio_button_unchecked,
    color: isDone ? Colors.green : Colors.grey,
  ),
)
```

## GlassContainer Surface Variants

```dart
// Primary — bold gradient, higher opacity, used for main CTAs
GlassContainer(variant: GlassSurfaceVariant.primary)

// Secondary — subtle gradient, used for cards and input fields
GlassContainer(variant: GlassSurfaceVariant.secondary)

// Circular — used for circular icon buttons
GlassContainer(variant: GlassSurfaceVariant.circular)

// AppBar — used for the translucent app bar
GlassContainer(variant: GlassSurfaceVariant.appBar)
```

## GlassDefaults

Shared numeric constants used across widgets:

| Constant | Value | Used by |
|---|---|---|
| `borderRadius` | 12.0 | Buttons, inputs, checkboxes |
| `paddingSmall` | 8.0 | General spacing |
| `paddingMedium` | 16.0 | Standard padding |
| `paddingLarge` | 24.0 | Large padding |
| `defaultLoaderSize` | 96.0 | GlassPulsingIndicator |
| `buttonHeight` | 54.0 | Button |

## Migration from mazraeati mixins

| Old (mazraeati) | New (glass_ui_kit) |
|---|---|
| `AppThemeTokens` | `GlassThemeTokens` |
| `AppConstant.primaryColor` | `GlassThemeTokens.of(context).primaryColor` |
| `AppConstant.borderRadius` | `GlassDefaults.borderRadius` |
| `AppConstant.paddingMedium` | `GlassDefaults.paddingMedium` |
| `GlassContainer` (from mixins) | `GlassContainer` (from package) |
| `GlassSurfaceVariant` (from mixins) | `GlassSurfaceVariant` (from package) |
| `Button` (from buttons_mixin) | `Button` (from package) |
| `AppLoadingWidget` (from loading_mixin) | `GlassPulsingIndicator` (no Lottie dep) |
| `SimpleCheckoutStepper` (from simple_step_checkout) | `GlassStepper` (with `GlassStepperStyle.glass/flat`) |
| `SimpleCheckoutStepperController` | `GlassStepperController` (same API) |
| `SimpleCheckoutStepperDirection` | `GlassStepperDirection` |
| `StepWidgetBuilder` | `StepperWidgetBuilder` |
| `doneColor` | `activeColor` (in flat mode; glass mode uses `tokens.primaryColor`) |
| `unDoneColor` | `inactiveColor` (in flat mode; glass mode uses `tokens.shadowColor`) |
| `stepIndexColor` | `stepNumberColor` |
| `hroizatalPadding` (typo) | `horizontalPadding` (fixed) |
| `baseAppBar(...)` | `GlassAppBar.build(...)` |
| `BaseWidget` with `Get.back()` | `BaseWidget` with `onBack:` or `Navigator.pop()` |
| `ButtonsMixin` | — (removed — use `Button` directly) |
| `InputsMixin` | — (removed — use widgets directly) |

## Issues and Feedback

Please file issues, bugs, and feature requests on our [Issue Tracker](https://github.com/abdulrasol/glass_ui_kit/issues).

## License

This package is available on GitHub and can be used directly from source.