import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class CircularIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onClick;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? iconColor;
  final bool enabled;
  final double? size;

  const CircularIconButton({
    required this.icon,
    this.onClick,
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.iconColor,
    this.enabled = true,
    this.size,
  });

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.enabled && widget.onClick != null;
    final tokens = GlassThemeTokens.of(context);
    final iconColor = widget.iconColor ?? tokens.contentPrimary;

    return Opacity(
      opacity: isEnabled ? 1 : 0.7,
      child: GestureDetector(
        onTapDown: isEnabled ? (_) => _animController.forward() : null,
        onTapUp: isEnabled ? (_) => _animController.reverse() : null,
        onTapCancel: isEnabled ? () => _animController.reverse() : null,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 999),
              onTap: isEnabled ? widget.onClick : null,
              onHighlightChanged: (value) => setState(() => _isPressed = value),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: tokens.primaryColor.withValues(alpha: 0.4),
                  ),
                ),
                child: GlassContainer(
                  height: widget.size ?? 44,
                  width: widget.size ?? 44,
                  borderRadius: widget.borderRadius ?? 999,
                  variant: GlassSurfaceVariant.circular,
                  isPressed: _isPressed,
                  isDisabled: !isEnabled,
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Icon(
                      widget.icon,
                      size: (widget.size ?? 44) * 0.45,
                      color: isEnabled
                          ? iconColor
                          : iconColor.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}