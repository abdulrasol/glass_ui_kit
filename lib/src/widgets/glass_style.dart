import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_surface_variant.dart';

/// Immutable resolved visual style for a glass surface.
/// Created by [GlassStyle.resolve] which reads from [GlassThemeTokens].
class GlassStyle {
  /// Gradient fill applied to the glass surface.
  final LinearGradient gradient;

  /// Layered highlight colors that simulate light refraction.
  final List<Color> highlightColors;

  /// Color of the glass border outline.
  final Color borderColor;

  /// Box shadows cast by the glass element.
  final List<BoxShadow> shadows;

  /// Internal padding within the glass surface.
  final EdgeInsetsGeometry padding;

  /// Border radius in logical pixels.
  final double borderRadius;

  /// Sigma value for the backdrop blur filter.
  final double blurSigma;

  /// Width of the border stroke.
  final double borderWidth;

  const GlassStyle({
    required this.gradient,
    required this.highlightColors,
    required this.borderColor,
    required this.shadows,
    required this.padding,
    required this.borderRadius,
    required this.blurSigma,
    required this.borderWidth,
  });

  /// Resolves a [GlassStyle] from the current theme tokens,
  /// surface variant, and interactive state.
  static GlassStyle resolve(
    BuildContext context, {
    /// The surface variant that determines the visual style.
    required GlassSurfaceVariant variant,

    /// Whether the surface is in a pressed state.
    required bool isPressed,

    /// Whether the surface is in a disabled state.
    required bool isDisabled,

    /// Optional override for the border radius.
    double? borderRadius,
  }) {
    final tokens = GlassThemeTokens.of(context);
    final opacity = isDisabled ? 0.52 : 1.0;

    switch (variant) {
      case GlassSurfaceVariant.primary:
        return GlassStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _fade(tokens.primarySurface1, (isPressed ? 0.38 : 0.45) * opacity),
              _fade(tokens.primarySurface2, (isPressed ? 0.28 : 0.35) * opacity),
              _fade(tokens.primarySurface3, (isPressed ? 0.32 : 0.40) * opacity),
            ],
          ),
          highlightColors: [
            _fade(Colors.white, 0.48 * opacity),
            _fade(Colors.white, 0.22 * opacity),
            Colors.transparent,
            _fade(Colors.black, 0.04 * opacity),
          ],
          borderColor: _fade(Colors.white, 0.18 * opacity),
          shadows: [
            BoxShadow(
              color: _fade(tokens.shadowColor, 0.62 * opacity),
              blurRadius: isPressed ? 14 : 24,
              offset: const Offset(0, 12),
              spreadRadius: -10,
            ),
          ],
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          borderRadius: borderRadius ?? 24,
          blurSigma: tokens.primaryBlurSigma,
          borderWidth: 0.8,
        );
      case GlassSurfaceVariant.secondary:
        return GlassStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _fade(tokens.secondarySurface1, (isPressed ? 0.20 : 0.26) * opacity),
              _fade(tokens.secondarySurface2, (isPressed ? 0.14 : 0.20) * opacity),
              _fade(tokens.secondarySurface3, (isPressed ? 0.10 : 0.16) * opacity),
            ],
          ),
          highlightColors: [
            _fade(Colors.white, 0.52 * opacity),
            _fade(Colors.white, 0.24 * opacity),
            Colors.transparent,
            _fade(Colors.black, 0.03 * opacity),
          ],
          borderColor: _fade(tokens.subtleOutlineColor, 0.72 * opacity),
          shadows: [
            BoxShadow(
              color: _fade(tokens.shadowColor, 0.42 * opacity),
              blurRadius: isPressed ? 10 : 16,
              offset: const Offset(0, 8),
              spreadRadius: -10,
            ),
          ],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          borderRadius: borderRadius ?? 22,
          blurSigma: tokens.secondaryBlurSigma,
          borderWidth: 0.75,
        );
      case GlassSurfaceVariant.circular:
        return GlassStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _fade(tokens.circularSurface1, (isPressed ? 0.16 : 0.22) * opacity),
              _fade(tokens.circularSurface2, (isPressed ? 0.08 : 0.14) * opacity),
            ],
          ),
          highlightColors: [
            _fade(Colors.white, 0.56 * opacity),
            _fade(Colors.white, 0.28 * opacity),
            Colors.transparent,
            _fade(Colors.black, 0.03 * opacity),
          ],
          borderColor: _fade(tokens.subtleOutlineColor, 0.62 * opacity),
          shadows: [
            BoxShadow(
              color: _fade(tokens.shadowColor, 0.40 * opacity),
              blurRadius: isPressed ? 8 : 14,
              offset: const Offset(0, 6),
              spreadRadius: -10,
            ),
          ],
          padding: const EdgeInsets.all(10),
          borderRadius: borderRadius ?? 999,
          blurSigma: tokens.circularBlurSigma,
          borderWidth: 0.7,
        );
      case GlassSurfaceVariant.appBar:
        return GlassStyle(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              tokens.appBarSurface1.withValues(alpha: 0.15),
              tokens.appBarSurface2.withValues(alpha: 0.35),
            ],
          ),
          highlightColors: [
            _fade(Colors.white, 0.12 * opacity),
            _fade(Colors.white, 0.06 * opacity),
            Colors.transparent,
            _fade(Colors.black, 0.02 * opacity),
          ],
          borderColor: Colors.transparent,
          shadows: const [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 0,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: borderRadius ?? 26,
          blurSigma: tokens.appBarBlurSigma,
          borderWidth: 0.0,
        );
    }
  }

  static Color _fade(Color color, double opacity) {
    return color.withValues(alpha: color.a * opacity);
  }
}