import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';

class PulsingGlassImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Widget? fallbackWidget;

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