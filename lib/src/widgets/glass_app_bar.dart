import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/glass_theme_tokens.dart';
import 'circular_back_button.dart';
import 'glass_container.dart';
import 'glass_surface_variant.dart';

class GlassAppBar {
  static PreferredSizeWidget build({
    String? title,
    bool withBack = true,
    List<Widget> actions = const [],
    bool transparentAppBar = false,
    bool centerTitle = false,
    PreferredSizeWidget? bottom,
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