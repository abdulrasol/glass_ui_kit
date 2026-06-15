import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';

/// Typed value-label pair for segmented chips.
class GlassSegmentedChipsItem<T> {
  /// The value this chip represents.
  final T value;

  /// The human-readable label shown on the chip.
  final String label;

  /// Creates a constant [GlassSegmentedChipsItem] with the given [value] and [label].
  const GlassSegmentedChipsItem({required this.value, required this.label});
}

/// Horizontal segmented chip selector with animated selected state.
class GlassSegmentedChipsPicker<T> extends StatelessWidget {
  /// Text displayed above the chip row.
  final String label;

  /// Currently selected value.
  final T value;

  /// List of selectable [GlassSegmentedChipsItem] entries.
  final List<GlassSegmentedChipsItem<T>> items;

  /// Callback invoked when the user selects a new chip value.
  final ValueChanged<T> onChanged;

  /// Creates a [GlassSegmentedChipsPicker] displaying a row of selectable chips.
  ///
  /// [label], [value], [items], and [onChanged] are required.
  const GlassSegmentedChipsPicker({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: tokens.contentPrimary.withValues(alpha: 0.8),
                  letterSpacing: 0.5,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: items.map((item) {
            final isSelected = item.value == value;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => onChanged(item.value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isSelected
                            ? tokens.primaryColor.withValues(alpha: 0.16)
                            : tokens.contentInverse.withValues(alpha: 0.05),
                        border: Border.all(
                          color: isSelected
                              ? tokens.primaryColor.withValues(alpha: 0.6)
                              : tokens.contentPrimary.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        item.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? tokens.primaryColor
                                  : tokens.contentPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}