import 'package:flutter/material.dart';

import '../views.dart';
import '../../resources/resources.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;

  const MainAppbar({required this.title, this.leading, this.actions, this.centerTitle = false, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      leading: leading,
      showDefaultBackButton: true,
      actions: actions,
      centerTitle: centerTitle,
      title: CustomText(title, fontSize: FontSize.s18),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
