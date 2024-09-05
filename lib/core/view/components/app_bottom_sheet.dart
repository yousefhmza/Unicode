import 'package:flutter/material.dart';
import 'package:unicode/core/extensions/num_extensions.dart';
import 'package:unicode/core/view/views.dart';

import '../../resources/resources.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;

  const AppBottomSheet({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppEdgeInsets.all(AppPadding.p16).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: AppBorderRadius.top(AppSize.s16)),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const ShapeDecoration(shape: StadiumBorder(), color: AppColors.grey300),
              width: AppSize.s150.w,
              height: AppSize.s4.h,
            ),
            const VerticalSpace(AppSize.s16),
            Flexible(
              child: SingleChildScrollView(
                padding: AppEdgeInsets.only(bottom: AppPadding.p16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
