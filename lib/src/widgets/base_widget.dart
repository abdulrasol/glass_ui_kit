import 'package:flutter/material.dart';
import '../theme/glass_theme_tokens.dart';
import 'glass_app_bar.dart';

class BaseWidget extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Widget Function(BuildContext context, double topPadding)? builder;
  final List<Widget> actions;
  final bool withBack;
  final EdgeInsetsGeometry? bodyPadding;
  final bool showAppBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool useTopSafeArea;
  final bool useBottomSafeArea;
  final bool extendBodyBehindAppBar;
  final bool transparentAppBar;
  final bool centerTitle;
  final PreferredSizeWidget? appBarBottom;
  final WidgetBuilder? overlayBuilder;
  final VoidCallback? onBack;
  final WidgetBuilder? backgroundBuilder;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool resizeToAvoidBottomInset;
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