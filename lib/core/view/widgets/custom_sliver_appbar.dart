import 'package:flutter/material.dart';
import 'package:unicode/core/extensions/num_extensions.dart';

import '../../resources/resources.dart';
import '../views.dart';

class CustomSliverAppbar extends StatelessWidget {
  final String title;
  final bool centerTitle;
  final List<Widget> actions;

  const CustomSliverAppbar({required this.title, required this.centerTitle, required this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: true,
      stretch: true,
      pinned: true,
      expandedHeight: AppSize.s125.h,
      collapsedHeight: kToolbarHeight.h,
      flexibleSpace: FlexibleSpaceBar(
        title: CustomText(title, fontWeight: FontWeightManager.bold, fontSize: FontSize.s24),
        centerTitle: centerTitle,
        titlePadding: AppEdgeInsets.symmetric(horizontal: AppPadding.p12).copyWith(bottom: AppPadding.p12),
        collapseMode: CollapseMode.parallax,
      ),
      actions: actions,
    );
  }
}
