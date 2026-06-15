/// A glassmorphism UI component library for Flutter with theme-driven design tokens.
///
/// Provides frosted-glass containers, buttons, form inputs, a full-page scaffold
/// ([BaseWidget]), and a theme extension ([GlassThemeTokens]) that drives all colors
/// and blur values. Zero external dependencies beyond Flutter.
///
/// Quick start:
/// ```dart
/// import 'package:glass_ui_kit/glass_ui_kit.dart';
///
/// MaterialApp(
///   theme: ThemeData(
///     useMaterial3: true,
///     extensions: [GlassThemeTokens.greenTheme(brightness: Brightness.light)],
///   ),
/// )
/// ```
library;

export 'src/theme/glass_defaults.dart';
export 'src/theme/glass_theme_tokens.dart';
export 'src/widgets/animated_glass_container.dart';
export 'src/widgets/base_widget.dart';
export 'src/widgets/button.dart';
export 'src/widgets/checkbox_field.dart';
export 'src/widgets/circular_back_button.dart';
export 'src/widgets/circular_icon_button.dart';
export 'src/widgets/dropdown_field.dart';
export 'src/widgets/glass_app_bar.dart';
export 'src/widgets/glass_container.dart';
export 'src/widgets/glass_pulsing_indicator.dart';
export 'src/widgets/glass_segmented_chips_picker.dart';
export 'src/widgets/glass_surface_variant.dart';
export 'src/widgets/number_input_field_with_buttons.dart';
export 'src/widgets/pulsing_glass_image.dart';
export 'src/widgets/submit_button.dart';
export 'src/widgets/text_input_field.dart';
export 'src/widgets/time_picker_field.dart';