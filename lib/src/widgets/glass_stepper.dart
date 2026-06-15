import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

/// Visual style for step circles and connecting lines in [GlassStepper].
///
/// - [glass]: Step circles use [GlassContainer] with backdrop blur and gradient
///   surfaces. All colors are derived from [GlassThemeTokens.of].
/// - [flat]: Step circles use flat colored circles. Colors default from
///   [GlassThemeTokens.of] but can be overridden via constructor params.
enum GlassStepperStyle { glass, flat }

/// Direction of the [GlassStepper].
///
/// - [horizontal]: Steps laid out in a row (default).
/// - [vertical]: Steps laid out in a column with titles beside each circle.
enum GlassStepperDirection { horizontal, vertical }

/// Builder function for custom step or title widgets.
///
/// [index] is the step index (0-based), [isDone] is true for completed and
/// active steps, [isActive] is true only for the current step.
typedef StepperWidgetBuilder = Widget Function(int index, bool isDone, bool isActive);

/// A glass-styled multi-step progress indicator.
///
/// Renders numbered step circles connected by lines. Supports two visual
/// modes controlled by [style]:
///
/// - [GlassStepperStyle.glass] (default): Step circles use frosted-glass
///   [GlassContainer] surfaces with colors derived from [GlassThemeTokens].
/// - [GlassStepperStyle.flat]: Step circles use flat colored circles with
///   token-aware defaults and optional constructor overrides.
///
/// Use the [stepBuilder], [stepTitleBuilder], and [stepLineWidget] parameters
/// to fully replace individual elements with custom widgets.
///
/// Requires a [GlassStepperController] for navigation and a
/// [GlassThemeTokens] extension in the current theme.
///
/// Example:
/// ```dart
/// GlassStepper(
///   controller: controller,
///   style: GlassStepperStyle.glass,
///   stepsList: const ['Cart', 'Address', 'Payment', 'Confirm'],
/// )
/// ```
class GlassStepper extends StatelessWidget {
  /// Controller managing the current step index and navigation.
  final GlassStepperController controller;

  /// Visual style for step circles and lines.
  ///
  /// [GlassStepperStyle.glass] uses [GlassContainer] surfaces,
  /// [GlassStepperStyle.flat] uses flat colored circles.
  final GlassStepperStyle style;

  /// Layout direction of the stepper.
  final GlassStepperDirection direction;

  /// Style for step title text.
  ///
  /// In flat mode, the [TextStyle.color] is overridden to [activeColor] or
  /// [inactiveColor]. In glass mode, it is overridden with token colors.
  final TextStyle? stepTitleStyle;

  /// Style for the number text inside step circles.
  ///
  /// The [TextStyle.color] is overridden by [stepNumberColor] in flat mode,
  /// or by [GlassThemeTokens.contentInverse] in glass mode.
  final TextStyle? stepNumberStyle;

  /// Color for completed and active step circles in flat mode.
  ///
  /// Ignored in glass mode; colors come from [GlassThemeTokens.primaryColor].
  final Color? activeColor;

  /// Color for incomplete step circles in flat mode.
  ///
  /// Ignored in glass mode; colors come from [GlassThemeTokens.shadowColor].
  final Color? inactiveColor;

  /// Color for the number text inside step circles in flat mode.
  ///
  /// Ignored in glass mode; colors come from [GlassThemeTokens.contentInverse].
  final Color? stepNumberColor;

  /// Top margin for step titles in horizontal mode, in logical pixels.
  final double titlePaddingTop;

  /// Thickness of the connecting line between steps, in logical pixels.
  final double lineSize;

  /// Custom builder replacing the entire step circle widget.
  ///
  /// Receives (index, isDone, isActive). When provided, the default
  /// step circle rendering is completely replaced.
  final StepperWidgetBuilder? stepBuilder;

  /// Custom builder replacing the entire step title widget.
  ///
  /// Receives (index, isDone, isActive). When provided, the default
  /// title rendering is completely replaced.
  final StepperWidgetBuilder? stepTitleBuilder;

  /// Custom widget replacing the connecting lines between steps.
  ///
  /// When provided, this widget is used in place of the default line.
  final Widget? stepLineWidget;

  /// Height of the connecting line container in vertical mode.
  final double? stepHeight;

  /// Width of the connecting line container in horizontal mode.
  ///
  /// When `null`, the line expands to fill available space.
  final double? stepWidth;

  /// Horizontal padding for step titles in vertical direction.
  final double? horizontalPadding;

  /// Gap between step circle and step title, in logical pixels.
  final double gapBetweenStepAndTitle;

  /// Inner padding for step circles in vertical direction.
  final double stepRadiusVertical;

  /// Inner padding for step circles in horizontal direction.
  final double stepRadiusHorizontal;

  const GlassStepper({
    super.key,
    required this.controller,
    this.style = GlassStepperStyle.glass,
    this.direction = GlassStepperDirection.horizontal,
    this.stepTitleStyle,
    this.stepNumberStyle,
    this.activeColor,
    this.inactiveColor,
    this.stepNumberColor,
    this.titlePaddingTop = 16,
    this.lineSize = 2,
    this.stepBuilder,
    this.stepTitleBuilder,
    this.stepLineWidget,
    this.stepHeight,
    this.stepWidth,
    this.horizontalPadding,
    this.gapBetweenStepAndTitle = 0,
    this.stepRadiusVertical = 0,
    this.stepRadiusHorizontal = 10,
  });

  @override
  Widget build(BuildContext context) {
    final isVertical = direction == GlassStepperDirection.vertical;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final index = controller.index;
        return isVertical
            ? LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth * 0.9;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildSteps(context, index, isVertical, horizontalPadding ?? width),
                  );
                },
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildSteps(context, index, isVertical, horizontalPadding ?? 0),
              );
      },
    );
  }

  List<Widget> _buildSteps(BuildContext context, int index, bool isVertical, double hPadding) {
    final list = <Widget>[];
    for (int i = 0; i < controller.steps; i++) {
      list.add(_buildStep(context, i, isVertical, hPadding));
      if (i < controller.steps - 1) {
        list.add(_buildLine(context, i, isVertical));
      }
    }
    return list;
  }

  Widget _buildStep(BuildContext context, int index, bool isVertical, double hPadding) {
    final tokens = GlassThemeTokens.of(context);
    final isDone = index <= controller.index;
    final isActive = index == controller.index;

    if (stepBuilder != null) {
      return _wrapStepWithTitle(
        context: context,
        index: index,
        isVertical: isVertical,
        hPadding: hPadding,
        isDone: isDone,
        isActive: isActive,
        stepWidget: stepBuilder!(index, isDone, isActive),
      );
    }

    final Widget stepWidget;
    if (style == GlassStepperStyle.glass) {
      stepWidget = _buildGlassStepCircle(index, isDone, isActive, isVertical, tokens);
    } else {
      stepWidget = _buildFlatStepCircle(index, isDone, isActive, isVertical, tokens);
    }

    return _wrapStepWithTitle(
      context: context,
      index: index,
      isVertical: isVertical,
      hPadding: hPadding,
      isDone: isDone,
      isActive: isActive,
      stepWidget: stepWidget,
    );
  }

  Widget _buildGlassStepCircle(int index, bool isDone, bool isActive, bool isVertical, GlassThemeTokens tokens) {
    final variant = isDone ? GlassSurfaceVariant.primary : GlassSurfaceVariant.secondary;
    final numberColor = isDone ? tokens.contentInverse : tokens.contentSecondary;

    return GlassContainer(
      variant: variant,
      borderRadius: 999,
      isPressed: isActive,
      isDisabled: !isDone,
      padding: EdgeInsets.symmetric(
        vertical: isVertical ? stepRadiusVertical : 10,
        horizontal: isVertical ? stepRadiusHorizontal : 10,
      ),
      child: Text(
        (index + 1).toString(),
        style: stepNumberStyle?.copyWith(color: numberColor) ??
            TextStyle(color: numberColor, fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }

  Widget _buildFlatStepCircle(int index, bool isDone, bool isActive, bool isVertical, GlassThemeTokens tokens) {
    final resolvedActiveColor = activeColor ?? tokens.primaryColor;
    final resolvedInactiveColor = inactiveColor ?? tokens.shadowColor;
    final resolvedNumberColor = stepNumberColor ?? tokens.contentInverse;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isVertical ? stepRadiusVertical : 10,
        horizontal: isVertical ? stepRadiusHorizontal : 10,
      ),
      decoration: BoxDecoration(
        color: isDone ? resolvedActiveColor : resolvedInactiveColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        (index + 1).toString(),
        style: stepNumberStyle?.copyWith(color: resolvedNumberColor) ??
            TextStyle(color: resolvedNumberColor, fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }

  Widget _wrapStepWithTitle({
    required BuildContext context,
    required int index,
    required bool isVertical,
    required double hPadding,
    required bool isDone,
    required bool isActive,
    required Widget stepWidget,
  }) {
    final tokens = GlassThemeTokens.of(context);

    if (!controller.showTitles) {
      if (isVertical) {
        return Row(mainAxisSize: MainAxisSize.min, children: [stepWidget]);
      } else {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [stepWidget]);
      }
    }

    final Color titleColor;
    if (style == GlassStepperStyle.glass) {
      titleColor = isDone ? tokens.contentPrimary : tokens.contentSecondary;
    } else {
      final resolvedActiveColor = activeColor ?? tokens.primaryColor;
      final resolvedInactiveColor = inactiveColor ?? tokens.shadowColor;
      titleColor = isDone ? resolvedActiveColor : resolvedInactiveColor;
    }

    final titleWidget = SizedBox(
      width: 0,
      height: 0,
      child: OverflowBox(
        fit: OverflowBoxFit.deferToChild,
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Container(
          alignment: Alignment.centerRight,
          margin: isVertical
              ? EdgeInsets.only(right: hPadding - gapBetweenStepAndTitle)
              : EdgeInsets.only(top: titlePaddingTop),
          child: SizedBox(
            width: isVertical ? hPadding : null,
            child: stepTitleBuilder?.call(index, isDone, isActive) ??
                Text(
                  controller.stepsList?[index] ?? "",
                  maxLines: 1,
                  style: stepTitleStyle?.copyWith(color: titleColor) ??
                      TextStyle(color: titleColor, fontWeight: FontWeight.w600, fontSize: 13),
                ),
          ),
        ),
      ),
    );

    final children = [stepWidget, titleWidget];

    if (isVertical) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: children);
    }
  }

  Widget _buildLine(BuildContext context, int index, bool isVertical) {
    if (stepLineWidget != null) {
      if (isVertical) {
        return SizedBox(height: stepHeight, child: stepLineWidget);
      }
      if (stepWidth != null) {
        return SizedBox(width: stepWidth, child: stepLineWidget);
      }
      return Expanded(child: stepLineWidget!);
    }

    final tokens = GlassThemeTokens.of(context);
    final isDone = index < controller.index;
    final Color lineColor;

    if (style == GlassStepperStyle.glass) {
      lineColor = isDone ? tokens.primaryColor : tokens.subtleOutlineColor;
    } else {
      final resolvedActiveColor = activeColor ?? tokens.primaryColor;
      final resolvedInactiveColor = inactiveColor ?? tokens.shadowColor;
      lineColor = isDone ? resolvedActiveColor : resolvedInactiveColor;
    }

    if (isVertical) {
      return SizedBox(
        height: stepHeight,
        child: Container(
          width: lineSize,
          decoration: BoxDecoration(
            color: lineColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    if (stepWidth != null) {
      return SizedBox(
        width: stepWidth,
        child: Center(
          child: Container(
            height: lineSize,
            decoration: BoxDecoration(
              color: lineColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Center(
        child: Container(
          height: lineSize,
          decoration: BoxDecoration(
            color: lineColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

/// Controller for [GlassStepper] that manages step navigation.
///
/// Use [next], [previous], and [reset] to change the current step.
/// The widget rebuilds automatically via [ChangeNotifier].
///
/// Example:
/// ```dart
/// final controller = GlassStepperController(steps: 4);
/// controller.next();  // advance
/// controller.previous();  // go back
/// controller.reset();  // back to step 0
/// ```
class GlassStepperController extends ChangeNotifier {
  int _index = 0;

  /// Total number of steps. Must be greater than 0.
  final int steps;

  /// Optional list of step title strings. Length must match [steps].
  List<String>? stepsList;

  /// Whether to display step titles. Defaults to `true`.
  final bool showTitles;

  /// Creates a [GlassStepperController].
  ///
  /// [steps] must be greater than 0. If [stepsList] is provided, its length
  /// must equal [steps].
  GlassStepperController({required this.steps, this.stepsList, this.showTitles = true})
      : assert(steps > 0, 'steps must be greater than 0'),
        assert(stepsList == null || stepsList.length == steps,
            'stepsList length must equal steps');

  /// Current step index (0-based).
  int get index => _index;

  /// Advance to the next step. Does nothing if already at the last step.
  void next() {
    if (_index < steps) {
      _index++;
      notifyListeners();
    }
  }

  /// Go back one step. Does nothing if already at the first step.
  void previous() {
    if (_index > 0) {
      _index--;
      notifyListeners();
    }
  }

  /// Reset to the first step (index 0).
  void reset() {
    _index = 0;
    notifyListeners();
  }
}