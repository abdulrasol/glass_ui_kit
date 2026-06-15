import 'package:flutter/material.dart';
import '../theme/glass_defaults.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_container.dart';
import 'glass_pulsing_indicator.dart';
import 'glass_surface_variant.dart';

enum GlassButtonVariant { primary, secondary }

class Button extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String? hintText;
  final VoidCallback? onClick;
  final bool? isLoading;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? textColor;
  final bool isFullWidth;
  final GlassButtonVariant? variant;
  final bool enabled;
  final Widget? loadingWidget;

  const Button({
    required this.label,
    this.icon,
    this.hintText,
    this.onClick,
    super.key,
    this.isLoading,
    this.backgroundColor,
    this.borderRadius,
    this.textColor,
    this.isFullWidth = true,
    this.variant,
    this.enabled = true,
    this.loadingWidget,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    final isLoading = widget.isLoading ?? false;
    final isEnabled = widget.enabled && !isLoading && widget.onClick != null;
    final variant = _resolveVariant();
    final textColor = widget.textColor ?? _resolveTextColor(variant, isEnabled);

    return Opacity(
      opacity: isEnabled ? 1 : 0.76,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useFullWidth =
              widget.isFullWidth && constraints.hasBoundedWidth;

          return GestureDetector(
            onTapDown: isEnabled ? (_) => _animController.forward() : null,
            onTapUp: isEnabled ? (_) => _animController.reverse() : null,
            onTapCancel: isEnabled ? () => _animController.reverse() : null,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                width: useFullWidth ? double.infinity : null,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? GlassDefaults.borderRadius + 8,
                    ),
                    onTap: isEnabled ? widget.onClick : null,
                    onHighlightChanged: (value) =>
                        setState(() => _isPressed = value),
                    child: GlassContainer(
                      height: GlassDefaults.buttonHeight,
                      borderRadius:
                          widget.borderRadius ?? GlassDefaults.borderRadius + 8,
                      variant: _mapSurfaceVariant(variant),
                      isPressed: _isPressed,
                      isDisabled: !isEnabled,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.1,
                            ),
                        child: Row(
                          mainAxisSize: useFullWidth
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isLoading)
                              widget.loadingWidget ??
                                  const GlassPulsingIndicator(size: 25)
                            else if (widget.icon != null)
                              Icon(widget.icon, size: 18, color: textColor),
                            if ((isLoading || widget.icon != null) &&
                                widget.label.isNotEmpty)
                              const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  GlassButtonVariant _resolveVariant() {
    if (widget.variant != null) return widget.variant!;
    if (widget.backgroundColor == Colors.transparent) {
      return GlassButtonVariant.secondary;
    }
    return GlassButtonVariant.primary;
  }

  GlassSurfaceVariant _mapSurfaceVariant(GlassButtonVariant variant) {
    switch (variant) {
      case GlassButtonVariant.primary:
        return GlassSurfaceVariant.primary;
      case GlassButtonVariant.secondary:
        return GlassSurfaceVariant.secondary;
    }
  }

  Color _resolveTextColor(GlassButtonVariant variant, bool isEnabled) {
    final tokens = GlassThemeTokens.of(context);
    final baseColor = switch (variant) {
      GlassButtonVariant.primary => tokens.contentInverse,
      GlassButtonVariant.secondary => tokens.contentPrimary,
    };
    return isEnabled ? baseColor : baseColor.withValues(alpha: 0.75);
  }
}