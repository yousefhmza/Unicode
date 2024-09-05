import 'package:flutter/material.dart';
import 'package:unicode/core/extensions/num_extensions.dart';

import '../../../config/localization/l10n/l10n.dart';
import '../../../config/navigation/navigation.dart';
import '../../resources/resources.dart';
import '../views.dart';

class ConfirmationDialog extends StatelessWidget {
  final String image;
  final String title;
  final String? confirmationText;
  final String? cancellationText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    this.image = AppImages.mobile,
    this.confirmationText,
    this.cancellationText,
    required this.title,
    required this.onConfirm,
    this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.all(AppSize.s12)),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: [
          Positioned(
            left: AppSize.s0,
            right: AppSize.s0,
            top: -AppSize.s56.w,
            child: Image.asset(image, height: AppSize.s82.w, width: AppSize.s82.w),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpace(AppSize.s48),
              Padding(
                padding: AppEdgeInsets.all(AppPadding.p12),
                child: CustomText(title, fontWeight: FontWeightManager.bold, textAlign: TextAlign.center),
              ),
              const VerticalSpace(AppSize.s24),
              const Divider(height: AppSize.s0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        NavigationService.goBack(context);
                        if (onCancel != null) onCancel!();
                      },
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(AppSize.s12)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.only(bottomStart: AppSize.s12),
                        ),
                        padding: AppEdgeInsets.all(AppPadding.p12),
                        alignment: Alignment.center,
                        child: CustomText(
                          cancellationText ?? L10n.tr(context).cancel,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: AppColors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: AppBorderRadius.only(bottomEnd: AppSize.s12),
                        ),
                        child: InkWell(
                          onTap: () {
                            NavigationService.goBack(context);
                            onConfirm();
                          },
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(AppSize.s12)),
                          child: Container(
                            padding: AppEdgeInsets.all(AppPadding.p12),
                            alignment: Alignment.center,
                            child: CustomText(
                              confirmationText ?? L10n.tr(context).confirm,
                              color: AppColors.white,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
