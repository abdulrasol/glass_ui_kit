import 'package:flutter/cupertino.dart';
import 'circular_icon_button.dart';

/// RTL-aware back navigation button.
/// Defaults to [Navigator.of(context).pop()].
/// Override with [onBack] for custom behavior.
class CircularBackButton extends StatelessWidget {
  /// Optional callback for custom back navigation behavior.
  /// When null, defaults to [Navigator.of(context).pop()].
  final VoidCallback? onBack;

  const CircularBackButton({this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    final currentDirection = Directionality.of(context);
    final isRTL = currentDirection == TextDirection.rtl;

    return Padding(
      padding: EdgeInsets.only(left: isRTL ? 0 : 4, right: isRTL ? 4 : 0),
      child: CircularIconButton(
        icon: isRTL
            ? CupertinoIcons.chevron_right
            : CupertinoIcons.chevron_left,
        onClick: onBack ?? () => Navigator.of(context).pop(),
      ),
    );
  }
}