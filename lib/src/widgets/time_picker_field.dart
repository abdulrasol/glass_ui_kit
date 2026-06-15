import 'package:flutter/material.dart';
import '../theme/glass_defaults.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class TimePickerField extends StatefulWidget {
  final String label;
  final ValueChanged<TimeOfDay?> onTimeSelected;
  final TimeOfDay? initialTime;

  const TimePickerField({
    super.key,
    required this.label,
    required this.onTimeSelected,
    this.initialTime,
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  TimeOfDay? _selectedTime;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: tokens.contentPrimary,
              ),
        ),
        const SizedBox(height: 10),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(GlassDefaults.borderRadius + 8),
            onTap: _selectTime,
            onHighlightChanged: (value) => setState(() => _isPressed = value),
            child: GlassContainer(
              variant: GlassSurfaceVariant.secondary,
              borderRadius: GlassDefaults.borderRadius + 8,
              isPressed: _isPressed,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime?.format(context) ?? 'Select time',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: tokens.contentPrimary,
                          ),
                    ),
                  ),
                  Icon(
                    Icons.access_time_rounded,
                    color: tokens.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}