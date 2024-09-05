import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/resources.dart';
import '../views.dart';

class LoadingDialog extends BasePlatformWidget<AlertDialog, CupertinoAlertDialog> {
  const LoadingDialog({super.key});

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: LoadingSpinner(margin: AppEdgeInsets.all(AppPadding.p16)),
    );
  }

  @override
  AlertDialog createMaterialWidget(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.all(AppSize.s8)),
      clipBehavior: Clip.antiAlias,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingSpinner(margin: AppEdgeInsets.all(AppPadding.p16)),
        ],
      ),
    );
  }
}
