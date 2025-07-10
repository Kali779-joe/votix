import 'package:flutter/material.dart';



class VotixAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final Widget? leading;
  final Widget? titleWidget;
  final Widget? logo;

  const VotixAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.elevation = 0.5,
    this.leading,
    this.titleWidget,
    this.logo,
    required bool automaticallyImplyLeading,
    required int height,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.primary,
      elevation: elevation,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? leading ?? _defaultBackButton(context)
          : null,
      title: titleWidget ??
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  Widget _defaultBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).maybePop(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
class AppColors {
  static const Color primary = Color(0xFF30094c);  // Purple
  static const Color accent = Color(0xFF47c599);   // Mint green
  static const Color background = Color(0xFF121212);
  static const Color text = Colors.white;
}



