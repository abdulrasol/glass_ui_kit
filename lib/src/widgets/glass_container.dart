import 'dart:ui';

import 'package:flutter/material.dart';
import 'glass_surface_variant.dart';
import 'glass_style.dart';

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final GlassSurfaceVariant variant;
  final double? borderRadius;
  final bool isPressed;
  final bool isDisabled;

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