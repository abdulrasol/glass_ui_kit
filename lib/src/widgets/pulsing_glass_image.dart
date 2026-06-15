import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';

/// A network image viewer that displays a shimmer glass gradient during loading
/// and gracefully transitions when done.
class PulsingGlassImage extends StatefulWidget {
  /// URL of the network image to display.
  final String imageUrl;

  /// Fixed width of the image area. Defaults to intrinsic sizing if `null`.
  final double? width;

  /// Fixed height of the image area. Defaults to intrinsic sizing if `null`.
  final double? height;

  /// Corner radius applied to the clipped shape. Defaults to 16 px.
  final BorderRadius? borderRadius;

  /// How the image should be inscribed into the layout bounds.
  final BoxFit fit;

  /// Widget displayed when the URL is empty, not HTTP, or the image fails to
  /// load. Falls back to a placeholder icon when `null`.
  final Widget? fallbackWidget;

  /// Creates a pulsing glass image viewer.
  ///
  /// * [imageUrl] – HTTP(S) URL of the image to load.
  /// * [width] – fixed container width; intrinsic when `null`.
  /// * [height] – fixed container height; intrinsic when `null`.
  /// * [borderRadius] – rounded corners; defaults to `BorderRadius.circular(16)`.
  /// * [fit] – image fill mode; defaults to [BoxFit.cover].
  /// * [fallbackWidget] – custom widget shown on error or invalid URL.
  const PulsingGlassImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.fallbackWidget,
  });

  @override
  State<PulsingGlassImage> createState() => _PulsingGlassImageState();
}

class _PulsingGlassImageState extends State<PulsingGlassImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark
        ? tokens.circularSurface1.withValues(alpha: 0.15)
        : tokens.circularSurface1.withValues(alpha: 0.45);
    final highlightColor = isDark
        ? tokens.primarySurface1.withValues(alpha: 0.3)
        : Colors.white.withValues(alpha: 0.85);

    final border = widget.borderRadius ?? BorderRadius.circular(16);

    if (widget.imageUrl.isEmpty || !widget.imageUrl.startsWith('http')) {
      return widget.fallbackWidget ??
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(color: baseColor, borderRadius: border),
            child: Icon(
              Icons.image_not_supported_rounded,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          );
    }

    return ClipRRect(
      borderRadius: border,
      child: Image.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) {
          return widget.fallbackWidget ??
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: border,
                ),
                child: Icon(
                  Icons.image_not_supported_rounded,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, _) {
              final val = _shimmerController.value;
              return Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: border,
                  gradient: LinearGradient(
                    begin: Alignment(-1.0 + (val * 2.0), -0.3),
                    end: Alignment(0.0 + (val * 2.0), 0.3),
                    colors: [baseColor, highlightColor, baseColor],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}