import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final bool? enabled;
  final FormFieldValidator<String>? validator;
  final Widget? suffix;

  const TextInputField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChanged,
    this.icon,
    this.enabled,
    this.validator,
    this.suffix,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _isFocused = false;

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
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 20,
                    color: tokens.contentPrimary.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: TextFormField(
                    enabled: widget.enabled,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    maxLines: widget.maxLines,
                    onChanged: widget.onChanged,
                    validator: widget.validator,
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
                      suffix: widget.suffix,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}