import 'package:flutter/material.dart';

import '../fonts/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final double elevation;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final Gradient? gradient;

  const CustomAppBar({
    super.key,
    this.title = '',
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.automaticallyImplyLeading = false,
    this.elevation = 4.0,
    this.titleStyle,
    this.backgroundColor = Colors.white,
    this.gradient, // ✅ optional gradient
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style:
            titleStyle ??
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,

      iconTheme: IconThemeData(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),

      backgroundColor: gradient == null ? backgroundColor : Colors.transparent,

      shadowColor: Colors.black.withValues(alpha: 0.25),

      flexibleSpace: gradient != null
          ? Container(decoration: BoxDecoration(gradient: gradient))
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
