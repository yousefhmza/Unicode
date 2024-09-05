import 'package:flutter/material.dart';
import 'package:unicode/core/extensions/num_extensions.dart';

import '../../resources/resources.dart';
import '../views.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  final double? height;
  final double? width;
  final double? textHeight;
  final double? borderRadius;
  final double fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? spinnerColor;
  final bool isOutlined;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.onPressed,
    this.text = "",
    this.color,
    this.textColor,
    this.child,
    this.width,
    this.height,
    this.textHeight,
    this.borderRadius,
    this.fontWeight,
    this.padding,
    this.margin,
    this.spinnerColor,
    this.isOutlined = false,
    this.isLoading = false,
    this.fontSize = FontSize.s16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width?.w,
      height: height?.h,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: isOutlined ? Border.all(color: color ?? AppColors.grey300) : null,
            color: isOutlined
                ? null
                : onPressed == null
                    ? AppColors.grey300
                    : color ?? AppColors.black,
            borderRadius: AppBorderRadius.all(borderRadius ?? AppSize.s12),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: AppBorderRadius.all(borderRadius ?? AppSize.s12),
            child: Container(
              padding: height != null
                  ? AppEdgeInsets.symmetric(horizontal: AppPadding.p16)
                  : padding ?? AppEdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p16),
              child: isLoading
                  ? LoadingSpinner(hasSmallRadius: true, color: spinnerColor ?? AppColors.white)
                  : text.isNotEmpty
                      ? CustomText(
                          text,
                          color: onPressed == null ? AppColors.grey400 : textColor ?? AppColors.white,
                          fontWeight: fontWeight ?? FontWeightManager.semiBold,
                          fontSize: fontSize,
                          textAlign: TextAlign.center,
                          height: textHeight,
                        )
                      : child,
            ),
          ),
        ),
      ),
    );
  }
}
