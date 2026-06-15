import 'package:flutter/material.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class AnimatedGlassContainer extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final GlassSurfaceVariant variant;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Duration animationDuration;

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