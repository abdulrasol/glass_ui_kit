import 'package:flutter/material.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

/// A pulsing glass loading indicator. Pure Flutter animation — no Lottie
/// dependency.
class GlassPulsingIndicator extends StatefulWidget {
  /// Diameter (width and height) of the indicator square. Defaults to 96.
  final double size;

  /// Creates a pulsing glass loading indicator.
  ///
  /// * [size] – width and height of the indicator; defaults to `96.0`.
  const GlassPulsingIndicator({super.key, this.size = 96.0});

  @override
  State<GlassPulsingIndicator> createState() => _GlassPulsingIndicatorState();
}

class _GlassPulsingIndicatorState extends State<GlassPulsingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final scale = 0.85 + (_controller.value * 0.15);
          return Transform.scale(
            scale: scale,
            child: GlassContainer(
              variant: GlassSurfaceVariant.primary,
              borderRadius: widget.size * 0.3,
              padding: EdgeInsets.zero,
              child: Center(
                child: SizedBox(
                  width: widget.size * 0.25,
                  height: widget.size * 0.25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}