import 'package:flutter/material.dart';

class GlassThemeTokens extends ThemeExtension<GlassThemeTokens> {
  final Color primaryColor;
  final Color backgroundStart;
  final Color backgroundMiddle;
  final Color backgroundEnd;
  final Color backgroundGlowPrimary;
  final Color backgroundGlowSecondary;
  final Color contentPrimary;
  final Color contentSecondary;
  final Color contentInverse;
  final Color dropdownBackgroundColor;
  final Color shadowColor;
  final Color subtleOutlineColor;
  final Color primarySurface1;
  final Color primarySurface2;
  final Color primarySurface3;
  final Color secondarySurface1;
  final Color secondarySurface2;
  final Color secondarySurface3;
  final Color circularSurface1;
  final Color circularSurface2;
  final Color appBarSurface1;
  final Color appBarSurface2;
  final double primaryBlurSigma;
  final double secondaryBlurSigma;
  final double circularBlurSigma;
  final double appBarBlurSigma;

  const GlassThemeTokens({
    required this.primaryColor,
    required this.backgroundStart,
    required this.backgroundMiddle,
    required this.backgroundEnd,
    required this.backgroundGlowPrimary,
    required this.backgroundGlowSecondary,
    required this.contentPrimary,
    required this.contentSecondary,
    required this.contentInverse,
    required this.dropdownBackgroundColor,
    required this.shadowColor,
    required this.subtleOutlineColor,
    required this.primarySurface1,
    required this.primarySurface2,
    required this.primarySurface3,
    required this.secondarySurface1,
    required this.secondarySurface2,
    required this.secondarySurface3,
    required this.circularSurface1,
    required this.circularSurface2,
    required this.appBarSurface1,
    required this.appBarSurface2,
    required this.primaryBlurSigma,
    required this.secondaryBlurSigma,
    required this.circularBlurSigma,
    required this.appBarBlurSigma,
  });

  static GlassThemeTokens of(BuildContext context) {
    return Theme.of(context).extension<GlassThemeTokens>()!;
  }

  factory GlassThemeTokens.greenTheme({required Brightness brightness}) {
    final isDark = brightness == Brightness.dark;
    return GlassThemeTokens(
      primaryColor: isDark ? const Color(0xFF84D2A6) : const Color(0xFF51A882),
      backgroundStart: isDark ? const Color(0xFF09110D) : const Color(0xFFF8F5ED),
      backgroundMiddle: isDark ? const Color(0xFF102119) : const Color(0xFFE9F2E7),
      backgroundEnd: isDark ? const Color(0xFF173326) : const Color(0xFFD8E9D7),
      backgroundGlowPrimary: isDark ? const Color(0x555BC48B) : const Color(0x8C8DD6AA),
      backgroundGlowSecondary: isDark ? const Color(0x336FE0B6) : const Color(0x6676C4D0),
      contentPrimary: isDark ? const Color(0xFFF3FFF7) : const Color(0xFF163325),
      contentSecondary: isDark ? const Color(0xFFD7E9DE) : const Color(0xFF456454),
      contentInverse: Colors.white,
      dropdownBackgroundColor: isDark ? const Color(0xFF18382A) : const Color(0xFFF8FAF4),
      shadowColor: isDark ? const Color(0xC0000000) : const Color(0x2D31523F),
      subtleOutlineColor: isDark ? const Color(0x5CFFFFFF) : const Color(0x66F8FFF9),
      primarySurface1: isDark ? const Color(0xFF2D6A4C) : const Color(0xFF3F8D63),
      primarySurface2: isDark ? const Color(0xFF17402D) : const Color(0xFF1F7650),
      primarySurface3: isDark ? const Color(0xFF10281C) : const Color(0xFF28583F),
      secondarySurface1: isDark ? const Color(0xFF183628) : const Color(0xFFFDFEF8),
      secondarySurface2: isDark ? const Color(0xFF173125) : const Color(0xFFE8F2E4),
      secondarySurface3: isDark ? const Color(0xFF10241B) : const Color(0xFFDDECE0),
      circularSurface1: isDark ? const Color(0xFF1E3E2F) : const Color(0xFFF8FCF5),
      circularSurface2: isDark ? const Color(0xFF173326) : const Color(0xFFE0EDDE),
      appBarSurface1: isDark ? const Color(0xFF102119) : const Color(0xFFF3F8F1),
      appBarSurface2: isDark ? const Color(0xFF0D1712) : const Color(0xFFE9F2E7),
      primaryBlurSigma: isDark ? 26 : 24,
      secondaryBlurSigma: isDark ? 22 : 20,
      circularBlurSigma: isDark ? 20 : 18,
      appBarBlurSigma: isDark ? 32 : 30,
    );
  }

  factory GlassThemeTokens.fromSeed(Color seed, {required Brightness brightness}) {
    final isDark = brightness == Brightness.dark;
    final hsl = HSLColor.fromColor(seed);

    Color surface(double lightness, [double saturation = 0.5]) {
      return hsl.withLightness(lightness.clamp(0.0, 1.0)).withSaturation(saturation.clamp(0.0, 1.0)).toColor();
    }

    final backgroundStart = isDark ? surface(0.04, 0.3) : surface(0.97, 0.12);
    final backgroundMiddle = isDark ? surface(0.08, 0.4) : surface(0.92, 0.2);
    final backgroundEnd = isDark ? surface(0.12, 0.38) : surface(0.86, 0.22);

    return GlassThemeTokens(
      primaryColor: seed,
      backgroundStart: backgroundStart,
      backgroundMiddle: backgroundMiddle,
      backgroundEnd: backgroundEnd,
      backgroundGlowPrimary: isDark
          ? surface(0.4, 0.4).withValues(alpha: 0.33)
          : surface(0.6, 0.3).withValues(alpha: 0.55),
      backgroundGlowSecondary: isDark
          ? surface(0.5, 0.35).withValues(alpha: 0.2)
          : surface(0.55, 0.4).withValues(alpha: 0.4),
      contentPrimary: isDark ? const Color(0xFFF3FFF7) : surface(0.1, 0.6),
      contentSecondary: isDark ? surface(0.85, 0.15) : surface(0.3, 0.25),
      contentInverse: Colors.white,
      dropdownBackgroundColor: isDark ? surface(0.1, 0.35) : surface(0.97, 0.12),
      shadowColor: isDark
          ? const Color(0xC0000000)
          : Colors.black.withValues(alpha: 0.18),
      subtleOutlineColor: isDark
          ? Colors.white.withValues(alpha: 0.36)
          : Colors.white.withValues(alpha: 0.4),
      primarySurface1: isDark ? surface(0.33, 0.55) : surface(0.50, 0.42),
      primarySurface2: isDark ? surface(0.22, 0.60) : surface(0.40, 0.58),
      primarySurface3: isDark ? surface(0.14, 0.48) : surface(0.30, 0.40),
      secondarySurface1: isDark ? surface(0.10, 0.40) : surface(0.98, 0.18),
      secondarySurface2: isDark ? surface(0.08, 0.42) : surface(0.92, 0.25),
      secondarySurface3: isDark ? surface(0.06, 0.35) : surface(0.86, 0.20),
      circularSurface1: isDark ? surface(0.15, 0.35) : surface(0.97, 0.20),
      circularSurface2: isDark ? surface(0.12, 0.38) : surface(0.90, 0.18),
      appBarSurface1: isDark ? surface(0.07, 0.38) : surface(0.96, 0.18),
      appBarSurface2: isDark ? surface(0.04, 0.35) : surface(0.90, 0.30),
      primaryBlurSigma: isDark ? 26 : 24,
      secondaryBlurSigma: isDark ? 22 : 20,
      circularBlurSigma: isDark ? 20 : 18,
      appBarBlurSigma: isDark ? 32 : 30,
    );
  }

  @override
  GlassThemeTokens copyWith({
    Color? primaryColor,
    Color? backgroundStart,
    Color? backgroundMiddle,
    Color? backgroundEnd,
    Color? backgroundGlowPrimary,
    Color? backgroundGlowSecondary,
    Color? contentPrimary,
    Color? contentSecondary,
    Color? contentInverse,
    Color? dropdownBackgroundColor,
    Color? shadowColor,
    Color? subtleOutlineColor,
    Color? primarySurface1,
    Color? primarySurface2,
    Color? primarySurface3,
    Color? secondarySurface1,
    Color? secondarySurface2,
    Color? secondarySurface3,
    Color? circularSurface1,
    Color? circularSurface2,
    Color? appBarSurface1,
    Color? appBarSurface2,
    double? primaryBlurSigma,
    double? secondaryBlurSigma,
    double? circularBlurSigma,
    double? appBarBlurSigma,
  }) {
    return GlassThemeTokens(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundStart: backgroundStart ?? this.backgroundStart,
      backgroundMiddle: backgroundMiddle ?? this.backgroundMiddle,
      backgroundEnd: backgroundEnd ?? this.backgroundEnd,
      backgroundGlowPrimary: backgroundGlowPrimary ?? this.backgroundGlowPrimary,
      backgroundGlowSecondary: backgroundGlowSecondary ?? this.backgroundGlowSecondary,
      contentPrimary: contentPrimary ?? this.contentPrimary,
      contentSecondary: contentSecondary ?? this.contentSecondary,
      contentInverse: contentInverse ?? this.contentInverse,
      dropdownBackgroundColor: dropdownBackgroundColor ?? this.dropdownBackgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      subtleOutlineColor: subtleOutlineColor ?? this.subtleOutlineColor,
      primarySurface1: primarySurface1 ?? this.primarySurface1,
      primarySurface2: primarySurface2 ?? this.primarySurface2,
      primarySurface3: primarySurface3 ?? this.primarySurface3,
      secondarySurface1: secondarySurface1 ?? this.secondarySurface1,
      secondarySurface2: secondarySurface2 ?? this.secondarySurface2,
      secondarySurface3: secondarySurface3 ?? this.secondarySurface3,
      circularSurface1: circularSurface1 ?? this.circularSurface1,
      circularSurface2: circularSurface2 ?? this.circularSurface2,
      appBarSurface1: appBarSurface1 ?? this.appBarSurface1,
      appBarSurface2: appBarSurface2 ?? this.appBarSurface2,
      primaryBlurSigma: primaryBlurSigma ?? this.primaryBlurSigma,
      secondaryBlurSigma: secondaryBlurSigma ?? this.secondaryBlurSigma,
      circularBlurSigma: circularBlurSigma ?? this.circularBlurSigma,
      appBarBlurSigma: appBarBlurSigma ?? this.appBarBlurSigma,
    );
  }

  @override
  GlassThemeTokens lerp(covariant GlassThemeTokens? other, double t) {
    if (other is! GlassThemeTokens) return this;

    return GlassThemeTokens(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundStart: Color.lerp(backgroundStart, other.backgroundStart, t)!,
      backgroundMiddle: Color.lerp(backgroundMiddle, other.backgroundMiddle, t)!,
      backgroundEnd: Color.lerp(backgroundEnd, other.backgroundEnd, t)!,
      backgroundGlowPrimary: Color.lerp(backgroundGlowPrimary, other.backgroundGlowPrimary, t)!,
      backgroundGlowSecondary: Color.lerp(backgroundGlowSecondary, other.backgroundGlowSecondary, t)!,
      contentPrimary: Color.lerp(contentPrimary, other.contentPrimary, t)!,
      contentSecondary: Color.lerp(contentSecondary, other.contentSecondary, t)!,
      contentInverse: Color.lerp(contentInverse, other.contentInverse, t)!,
      dropdownBackgroundColor: Color.lerp(dropdownBackgroundColor, other.dropdownBackgroundColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      subtleOutlineColor: Color.lerp(subtleOutlineColor, other.subtleOutlineColor, t)!,
      primarySurface1: Color.lerp(primarySurface1, other.primarySurface1, t)!,
      primarySurface2: Color.lerp(primarySurface2, other.primarySurface2, t)!,
      primarySurface3: Color.lerp(primarySurface3, other.primarySurface3, t)!,
      secondarySurface1: Color.lerp(secondarySurface1, other.secondarySurface1, t)!,
      secondarySurface2: Color.lerp(secondarySurface2, other.secondarySurface2, t)!,
      secondarySurface3: Color.lerp(secondarySurface3, other.secondarySurface3, t)!,
      circularSurface1: Color.lerp(circularSurface1, other.circularSurface1, t)!,
      circularSurface2: Color.lerp(circularSurface2, other.circularSurface2, t)!,
      appBarSurface1: Color.lerp(appBarSurface1, other.appBarSurface1, t)!,
      appBarSurface2: Color.lerp(appBarSurface2, other.appBarSurface2, t)!,
      primaryBlurSigma: primaryBlurSigma + ((other.primaryBlurSigma - primaryBlurSigma) * t),
      secondaryBlurSigma: secondaryBlurSigma + ((other.secondaryBlurSigma - secondaryBlurSigma) * t),
      circularBlurSigma: circularBlurSigma + ((other.circularBlurSigma - circularBlurSigma) * t),
      appBarBlurSigma: appBarBlurSigma + ((other.appBarBlurSigma - appBarBlurSigma) * t),
    );
  }
}