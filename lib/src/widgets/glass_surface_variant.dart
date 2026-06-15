/// Surface variants that determine the glass visual style
/// (gradient, blur, opacity, border).
enum GlassSurfaceVariant {
  /// Bold surface for CTAs and prominent cards.
  primary,

  /// Subtle surface for inputs, list items, and secondary cards.
  secondary,

  /// Circular surface for icon buttons.
  circular,

  /// Translucent surface for the app bar.
  appBar,
}