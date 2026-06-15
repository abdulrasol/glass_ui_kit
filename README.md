# Glass UI Kit

A sleek, modern glassmorphism UI component library with theme-driven design tokens for Flutter.

## Features

- **Glassmorphism Design:** Beautiful translucent widgets with blur effects.
- **Theme-Driven:** Easily customizable design tokens using `GlassTheme`.
- **Pre-built Components:** Ready-to-use widgets including cards, buttons, app bars, and more.
- **Responsive & Safe Area Aware:** Built-in support for different screen sizes and safe areas.

## Getting started

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  glass_ui_kit:
    git:
      url: https://github.com/abdulrasol/glass_ui_kit.git
```

## Usage

Wrap your application or part of it with `GlassTheme` and start using the components.

```dart
import 'package:glass_ui_kit/glass_ui_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GlassTheme(
      theme: GlassThemeData.light(),
      child: const MyApp(),
    ),
  );
}
```

For more detailed examples, check out the components within the library.

## Issues and Feedback

Please file issues, bugs, and feature requests on our [Issue Tracker](https://github.com/abdulrasol/glass_ui_kit/issues).