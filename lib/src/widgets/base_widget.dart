import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_app_bar.dart';

/// Full-page glass scaffold with gradient background and glass AppBar.
///
/// Provides two content modes:
/// - [child] — for fixed content. SafeArea and default padding are applied automatically.
/// - [builder] — for scrollable content. Receives [topPadding] (AppBar height + status bar)
///   so you can use it in [ListView.padding] or [CustomScrollView].
///
/// Both [child] and [builder] cannot be null at the same time, and both cannot be
/// provided simultaneously — an [assert] enforces this.
///
/// Composition slots:
/// - [overlayBuilder] — positioned below the AppBar (e.g., connectivity bar)
/// - [backgroundBuilder] — replace the default gradient background (e.g., map background)
/// - [onBack] — override back navigation (defaults to Navigator.pop)
/// - [drawer] / [endDrawer] — Scaffold navigation drawers
///
/// Example:
/// ```dart
/// BaseWidget(
///   title: 'Home',
///   builder: (context, topPadding) {
///     return ListView(
///       padding: EdgeInsets.only(top: topPadding),
///       children: [...],
///     );
///   },
/// )
/// ```
class BaseWidget extends StatelessWidget {
  /// Title displayed in the glass AppBar.
  final String? title;

  /// Fixed content widget. SafeArea and default padding are applied automatically.
  /// Mutually exclusive with [builder].
  final Widget? child;

  /// Scrollable-content builder that receives [BuildContext] and [topPadding]
  /// (AppBar height + status bar). Mutually exclusive with [child].
  final Widget Function(BuildContext context, double topPadding)? builder;

  /// Action widgets displayed at the trailing end of the AppBar.
  final List<Widget> actions;

  /// Whether to show a back button in the AppBar. Defaults to `true`.
  final bool withBack;

  /// Padding applied around [child] content. Ignored when [builder] is used.
  final EdgeInsetsGeometry? bodyPadding;

  /// Whether to display the AppBar. Defaults to `true`.
  final bool showAppBar;

  /// Bottom navigation bar passed through to [Scaffold.bottomNavigationBar].
  final Widget? bottomNavigationBar;

  /// Floating action button passed through to [Scaffold.floatingActionButton].
  final Widget? floatingActionButton;

  /// Whether to apply top SafeArea padding when using [child] mode
  /// and the AppBar is not transparent. Defaults to `true`.
  final bool useTopSafeArea;

  /// Whether to apply bottom SafeArea padding when using [child] mode.
  /// Defaults to `false`.
  final bool useBottomSafeArea;

  /// Whether the body extends behind the AppBar. Defaults to `true`.
  final bool extendBodyBehindAppBar;

  /// Whether the AppBar background is fully transparent (no glass effect).
  /// Defaults to `true`.
  final bool transparentAppBar;

  /// Whether to center the title in the AppBar. Defaults to `false`.
  final bool centerTitle;

  /// Optional widget displayed below the AppBar (e.g., a [TabBar]).
  final PreferredSizeWidget? appBarBottom;

  /// Overlay widget positioned below the AppBar (e.g., connectivity banner).
  final WidgetBuilder? overlayBuilder;

  /// Callback invoked when the back button is pressed.
  /// Defaults to [Navigator.pop] when null.
  final VoidCallback? onBack;

  /// Replaces the default gradient background with a custom widget.
  final WidgetBuilder? backgroundBuilder;

  /// Drawer widget passed through to [Scaffold.drawer].
  final Widget? drawer;

  /// End drawer widget passed through to [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// Whether the scaffold should resize when the keyboard appears.
  /// Defaults to `true`.
  final bool resizeToAvoidBottomInset;

  /// Background color for the scaffold, overriding the default gradient.
  final Color? scaffoldBackgroundColor;

  const BaseWidget({
    super.key,
    this.title,
    this.child,
    this.builder,
    this.actions = const [],
    this.withBack = true,
    this.bodyPadding,
    this.showAppBar = true,
    this.useTopSafeArea = true,
    this.useBottomSafeArea = false,
    this.extendBodyBehindAppBar = true,
    this.transparentAppBar = true,
    this.centerTitle = false,
    this.appBarBottom,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.overlayBuilder,
    this.onBack,
    this.backgroundBuilder,
    this.drawer,
    this.endDrawer,
    this.resizeToAvoidBottomInset = true,
    this.scaffoldBackgroundColor,
  }) : assert(child != null || builder != null,
           'Either child or builder must be provided');

  @override
  Widget build(BuildContext context) {
    final tokens = GlassThemeTokens.of(context);
    final double topPadding = showAppBar
        ? AppBar().preferredSize.height + MediaQuery.paddingOf(context).top
        : MediaQuery.paddingOf(context).top;

    final Widget bodyContent = builder != null
        ? builder!(context, topPadding)
        : child!;

    final Widget backgroundWidget = backgroundBuilder != null
        ? backgroundBuilder!(context)
        : DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  tokens.backgroundStart,
                  tokens.backgroundMiddle,
                  tokens.backgroundEnd,
                ],
              ),
            ),
          );

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: scaffoldBackgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      endDrawer: endDrawer,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: showAppBar
          ? GlassAppBar.build(
              title: title,
              actions: actions,
              withBack: withBack,
              transparentAppBar: transparentAppBar,
              centerTitle: centerTitle,
              bottom: appBarBottom,
              onBack: onBack,
            )
          : null,
      body: Stack(
        children: [
          Positioned.fill(child: backgroundWidget),
          Positioned(top: -80, right: -40, child: _buildGlow(tokens.backgroundGlowPrimary, 220)),
          Positioned(bottom: 20, left: -60, child: _buildGlow(tokens.backgroundGlowSecondary, 240)),
          if (builder != null)
            Positioned.fill(child: bodyContent)
          else
            SafeArea(
              bottom: useBottomSafeArea,
              top: useTopSafeArea && !transparentAppBar,
              child: Padding(
                padding: bodyPadding ?? EdgeInsets.only(
                  right: 8,
                  left: 8,
                  bottom: MediaQuery.paddingOf(context).bottom,
                ),
                child: bodyContent,
              ),
            ),
          if (overlayBuilder != null)
            Positioned(
              top: showAppBar ? 64.0 : 0.0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: true,
                top: !showAppBar,
                child: overlayBuilder!(context),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGlow(Color color, double size) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.0)],
          ),
        ),
      ),
    );
  }
}