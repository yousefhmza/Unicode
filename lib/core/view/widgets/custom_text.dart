import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unicode/config/localization/l10n/l10n.dart';
import 'package:unicode/core/extensions/num_extensions.dart';

import '../../resources/resources.dart';

class CustomText extends StatelessWidget {
  final bool autoSized;
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final double? height;
  final int? maxLines;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const CustomText(
    this.text, {
    this.autoSized = false,
    this.color,
    this.fontSize = FontSize.s14,
    this.fontFamily,
    this.fontWeight = FontWeightManager.medium,
    this.textAlign,
    this.height,
    this.maxLines,
    this.decoration,
    this.decorationColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize.sp,
      fontFamily: fontFamily ?? (L10n.isAr(context) ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily),
      fontWeight: fontWeight,
      height: height?.h,
      decoration: decoration,
      decorationColor: decorationColor,
    );
    return autoSized
        ? AutoSizeText(
            text,
            textAlign: textAlign,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            maxLines: maxLines,
            style: textStyle,
            minFontSize: FontSize.s8.sp,
          )
        : Text(
            text,
            textAlign: textAlign,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            maxLines: maxLines,
            style: textStyle,
          );
  }
}
