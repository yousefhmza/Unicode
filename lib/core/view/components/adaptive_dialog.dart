import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/navigation/navigation.dart';
import '../../resources/resources.dart';
import '../views.dart';

class AdaptiveDialog extends BasePlatformWidget<Dialog, CupertinoAlertDialog> {
  final String title;
  final String button1Text;
  final String button2Text;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const AdaptiveDialog({
    required this.title,
    required this.button1Text,
    required this.button2Text,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    super.key,
  });

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(title),
      actions: [
        CupertinoDialogAction(
          child: CustomText(button1Text),
          onPressed: () {
            NavigationService.goBack();
            onButton1Pressed();
          },
        ),
        CupertinoDialogAction(
          child: CustomText(button2Text),
          onPressed: () {
            NavigationService.goBack();
            onButton2Pressed();
          },
        ),
      ],
    );
  }

  @override
  Dialog createMaterialWidget(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.all(AppPadding.p72),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: const EdgeInsets.all(AppPadding.p16), child: CustomText(title)),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: button1Text,
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p14, horizontal: AppPadding.p0),
                  onPressed: () {
                    NavigationService.goBack();
                    onButton1Pressed();
                  },
                  borderRadius: AppSize.s0,
                ),
              ),
              Expanded(
                child: CustomButton(
                  text: button2Text,
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p14, horizontal: AppPadding.p0),
                  onPressed: () {
                    NavigationService.goBack();
                    onButton2Pressed();
                  },
                  borderRadius: AppSize.s0,
                  color: AppColors.warning,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
