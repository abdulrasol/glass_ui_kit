import 'package:flutter/cupertino.dart';
import 'circular_icon_button.dart';

class CircularBackButton extends StatelessWidget {
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