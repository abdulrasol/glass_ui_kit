import 'package:flutter/material.dart';
import '../theme/glass_defaults.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class CheckboxField extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CheckboxField({
    super.key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);

    return GlassContainer(
      variant: GlassSurfaceVariant.secondary,
      borderRadius: GlassDefaults.borderRadius + 8,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              checkboxTheme: CheckboxThemeData(
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return tokens.primaryColor;
                  }
                  return tokens.subtleOutlineColor.withValues(alpha: 0.45);
                }),
                checkColor: WidgetStateProperty.all(Colors.white),
                side: BorderSide(color: tokens.subtleOutlineColor, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            child: Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value ?? false;
                });
                widget.onChanged(_isChecked);
              },
            ),
          ),
          Expanded(
            child: Text(
              widget.label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: tokens.contentPrimary),
            ),
          ),
        ],
      ),
    );
  }
}