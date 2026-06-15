import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

/// Circular glass button for icon actions.
/// Wraps a [GlassContainer] with [GlassSurfaceVariant.circular].
class CircularIconButton extends StatefulWidget {
  /// The icon to display inside the button.
  final IconData icon;

  /// Callback invoked when the button is tapped.
  final VoidCallback? onClick;

  /// Optional custom background color for the button.
  final Color? backgroundColor;

  /// Optional custom border radius; defaults to a circular shape.
  final double? borderRadius;

  /// Optional custom color for the icon.
  final Color? iconColor;

  /// Whether the button is interactive.
  final bool enabled;

  /// Optional diameter of the circular button; defaults to 44.
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