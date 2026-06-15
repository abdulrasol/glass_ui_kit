import 'dart:ui';

import 'package:flutter/material.dart';
import 'glass_surface_variant.dart';
import 'glass_style.dart';

/// Frosted-glass backdrop-blur container. The foundational surface widget
/// that all glass UI kit widgets compose on top of.
class GlassContainer extends StatelessWidget {
  /// Optional child widget rendered inside the container.
  final Widget? child;

  /// Fixed width of the container. Defaults to intrinsic sizing if `null`.
  final double? width;

  /// Fixed height of the container. Defaults to intrinsic sizing if `null`.
  final double? height;

  /// Inner padding around the [child]. Falls back to the resolved
  /// [GlassStyle.padding] when `null`.
  final EdgeInsetsGeometry? padding;

  /// Visual variant controlling blur, gradient, and border intensity.
  final GlassSurfaceVariant variant;

  /// Corner radius applied to the clipped shape and decoration.
  final double? borderRadius;

  /// Whether the container is in a pressed / active state, which dims
  /// highlights and adjusts the gradient.
  final bool isPressed;

  /// Whether the container is disabled, reducing opacity and contrast.
  final bool isDisabled;

  /// Creates a frosted-glass backdrop-blur container.
  ///
  /// * [child] – optional content placed inside the glass surface.
  /// * [width] – fixed container width; intrinsic when `null`.
  /// * [height] – fixed container height; intrinsic when `null`.
  /// * [padding] – inner spacing; falls back to [GlassStyle.padding].
  /// * [variant] – look-and-feel preset; defaults to [GlassSurfaceVariant.secondary].
  /// * [borderRadius] – rounded corner radius override.
  /// * [isPressed] – dims/brightens for an active feel; defaults to `false`.
  /// * [isDisabled] – reduces overall contrast; defaults to `false`.
  const GlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.variant = GlassSurfaceVariant.secondary,
    this.borderRadius,
    this.isPressed = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = GlassStyle.resolve(
      context,
      variant: variant,
      isPressed: isPressed,
      isDisabled: isDisabled,
      borderRadius: borderRadius,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(style.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: style.blurSigma,
          sigmaY: style.blurSigma,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(style.borderRadius),
            gradient: style.gradient,
            border: Border.all(
              color: style.borderColor,
              width: style.borderWidth,
            ),
            boxShadow: style.shadows,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(style.borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: style.highlightColors,
                      stops: const [0.0, 0.28, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 12,
                right: 12,
                child: IgnorePointer(
                  child: Container(
                    height: 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.0),
                          Colors.white.withValues(alpha: 0.46),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(style.borderRadius),
                    gradient: RadialGradient(
                      center: const Alignment(-0.82, -0.92),
                      radius: 1.12,
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height,
                padding: padding ?? style.padding,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}