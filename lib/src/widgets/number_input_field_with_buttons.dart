import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

/// Numeric stepper input with +/- buttons inside a glass container.
class NumberInputFieldWithButtons extends StatefulWidget {
  /// Text displayed above the numeric input.
  final String label;

  /// Controller for reading and editing the numeric text value.
  final TextEditingController controller;

  /// Placeholder text shown when the field is empty.
  final String hintText;

  /// Leading icon displayed next to the input.
  final IconData icon;

  /// Minimum allowed numeric value.
  final int minValue;

  /// Maximum allowed numeric value.
  final int maxValue;

  /// Amount to increment or decrement per button press.
  final int step;

  /// Optional units label displayed as a suffix inside the field.
  final String? unitSuffix;

  /// Creates a [NumberInputFieldWithButtons] with increment/decrement controls.
  ///
  /// [label], [controller], [hintText], and [icon] are required.
  const NumberInputFieldWithButtons({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.minValue = 0,
    this.maxValue = 365,
    this.step = 1,
    this.unitSuffix,
  });

  @override
  State<NumberInputFieldWithButtons> createState() =>
      _NumberInputFieldWithButtonsState();
}

class _NumberInputFieldWithButtonsState
    extends State<NumberInputFieldWithButtons> {
  bool _isFocused = false;

  void _increment() {
    final current =
        int.tryParse(widget.controller.text.trim()) ?? widget.minValue;
    if (current + widget.step <= widget.maxValue) {
      widget.controller.text = (current + widget.step).toString();
      setState(() {});
    }
  }

  void _decrement() {
    final current =
        int.tryParse(widget.controller.text.trim()) ?? widget.minValue;
    if (current - widget.step >= widget.minValue) {
      widget.controller.text = (current - widget.step).toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: tokens.contentPrimary.withValues(alpha: 0.8),
                  letterSpacing: 0.5,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (value) => setState(() => _isFocused = value),
          child: GlassContainer(
            variant: GlassSurfaceVariant.secondary,
            borderRadius: 20,
            isPressed: _isFocused,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: tokens.contentPrimary.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: tokens.contentPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                    cursorColor: tokens.primaryColor,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: tokens.contentPrimary.withValues(alpha: 0.65),
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      suffixText: widget.unitSuffix,
                      suffixStyle: TextStyle(
                        color: tokens.contentPrimary.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                _NumericAdjustmentButton(
                  icon: Icons.remove_rounded,
                  onPressed: _decrement,
                  tokens: tokens,
                ),
                const SizedBox(width: 8),
                _NumericAdjustmentButton(
                  icon: Icons.add_rounded,
                  onPressed: _increment,
                  tokens: tokens,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NumericAdjustmentButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final GlassThemeTokens tokens;

  const _NumericAdjustmentButton({
    required this.icon,
    required this.onPressed,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tokens.primaryColor.withValues(alpha: 0.12),
            border: Border.all(
              color: tokens.primaryColor.withValues(alpha: 0.28),
            ),
          ),
          child: Icon(icon, size: 18, color: tokens.primaryColor),
        ),
      ),
    );
  }
}