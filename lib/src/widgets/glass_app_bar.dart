import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/glass_theme_tokens.dart';
import 'circular_back_button.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

/// Utility class providing a static [build] method that creates a glass-styled
/// [AppBar] with optional translucent background.
class GlassAppBar {
  /// Creates a glass-styled [PreferredSizeWidget] for use as [Scaffold.appBar].
  ///
  /// Returns an [AppBar] with transparent background, a glass [flexibleSpace]
  /// (unless [transparentAppBar] is `true`), and optional back button, title,
  /// actions, and bottom widget.
  static PreferredSizeWidget build({
    /// Title text displayed in the AppBar.
    String? title,

    /// Whether to show a circular back button. Defaults to `true`.
    bool withBack = true,

    /// Action widgets displayed at the trailing end of the AppBar.
    List<Widget> actions = const [],

    /// When `true`, the AppBar has no glass background effect and is
    /// fully transparent. Defaults to `false`.
    bool transparentAppBar = false,

    /// Whether to center the title text. Defaults to `false`.
    bool centerTitle = false,

    /// Optional bottom widget (e.g., a [TabBar]) placed below the AppBar.
    PreferredSizeWidget? bottom,

    /// Callback invoked when the back button is pressed.
    /// Defaults to [Navigator.pop] when null.
    VoidCallback? onBack,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      flexibleSpace: transparentAppBar
          ? null
          : const GlassContainer(
              variant: GlassSurfaceVariant.appBar,
              borderRadius: 0,
              padding: EdgeInsets.zero,
            ),
      bottom: bottom,
      title: Builder(
        builder: (context) {
          final tokens = GlassThemeTokens.of(context);
          return Row(
            children: [
              if (centerTitle) ...[
                if (withBack) CircularBackButton(onBack: onBack) else const SizedBox(width: 48),
                const SizedBox(width: 8),
                Expanded(
                  child: title != null
                      ? Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: tokens.contentPrimary, fontSize: 20, fontWeight: FontWeight.w700),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 8),
                actions.isEmpty ? const SizedBox(width: 48) : Row(mainAxisSize: MainAxisSize.min, children: actions),
              ] else ...[
                if (withBack) ...[CircularBackButton(onBack: onBack), const SizedBox(width: 12)],
                if (title != null)
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: tokens.contentPrimary, fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  )
                else
                  const Spacer(),
                if (actions.isNotEmpty) ...[const SizedBox(width: 8), Row(mainAxisSize: MainAxisSize.min, children: actions)],
              ],
            ],
          );
        },
      ),
    );
  }
}