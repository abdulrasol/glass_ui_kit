import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class DropdownFieldItem<T> {
  final T value;
  final String label;

  const DropdownFieldItem({required this.value, required this.label});
}

class DropdownField<T> extends StatefulWidget {
  final String label;
  final T? value;
  final String? hintText;
  final List<DropdownFieldItem<T>> items;
  final ValueChanged<T?> onChanged;
  final IconData? icon;

  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.icon,
  });

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);
    final hasValue = widget.items.any((item) => item.value == widget.value);
    final resolvedValue = hasValue ? widget.value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: tokens.contentPrimary,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                  child: DropdownButtonFormField<T>(
                    key: ValueKey(resolvedValue),
                    initialValue: resolvedValue,
                    items: widget.items
                        .map(
                          (item) => DropdownMenuItem<T>(
                            value: item.value,
                            child: Text(item.label),
                          ),
                        )
                        .toList(),
                    onChanged: widget.onChanged,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: tokens.contentPrimary.withValues(alpha: 0.6),
                    ),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: tokens.contentPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: tokens.contentPrimary.withValues(alpha: 0.4),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    dropdownColor: tokens.dropdownBackgroundColor,
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