import 'package:flutter/material.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

/// A [GlassContainer] that continuously pulses with a subtle scale animation
/// (breathing effect).
class AnimatedGlassContainer extends StatefulWidget {
  /// Optional child widget rendered inside the animated glass surface.
  final Widget? child;

  /// Fixed width of the container. Defaults to intrinsic sizing if `null`.
  final double? width;

  /// Fixed height of the container. Defaults to intrinsic sizing if `null`.
  final double? height;

  /// Visual variant controlling blur, gradient, and border intensity.
  final GlassSurfaceVariant variant;

  /// Inner padding around the [child].
  final EdgeInsetsGeometry? padding;

  /// Corner radius applied to the clipped shape and decoration.
  final double? borderRadius;

  /// Duration of one full scale-in ↔ scale-out cycle. Defaults to 8 seconds.
  final Duration animationDuration;

  /// Creates an animated glass container that continuously pulses.
  ///
  /// * [child] – optional content placed inside the glass surface.
  /// * [width] – fixed container width; intrinsic when `null`.
  /// * [height] – fixed container height; intrinsic when `null`.
  /// * [variant] – look-and-feel preset; defaults to [GlassSurfaceVariant.primary].
  /// * [padding] – inner spacing around [child].
  /// * [borderRadius] – rounded corner radius override.
  /// * [animationDuration] – length of one breathing cycle; defaults to 8 s.
  const AnimatedGlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.variant = GlassSurfaceVariant.primary,
    this.padding,
    this.borderRadius,
    this.animationDuration = const Duration(seconds: 8),
  });

  @override
  State<AnimatedGlassContainer> createState() => _AnimatedGlassContainerState();
}

class _AnimatedGlassContainerState extends State<AnimatedGlassContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final pulse = Curves.easeInOut.transform(_controller.value);
        return Transform.scale(
          scale: 1 + (pulse * 0.008),
          child: GlassContainer(
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            borderRadius: widget.borderRadius,
            variant: widget.variant,
            child: widget.child,
          ),
        );
      },
    );
  }
}