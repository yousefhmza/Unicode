import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicode/core/extensions/num_extensions.dart';
import 'package:unicode/core/view/views.dart';
//
import '../../resources/resources.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color? baseColor;
  final Color? highLightColor;

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.baseColor,
    this.highLightColor,
    this.shapeBorder = const CircleBorder(),
    super.key,
  });

  ShimmerWidget.rectangular({
    required this.height,
    this.width = double.infinity,
    this.baseColor,
    this.highLightColor,
    double borderRadius = AppSize.s6,
    super.key,
  }) : shapeBorder = RoundedRectangleBorder(borderRadius: AppBorderRadius.all(borderRadius));

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade100,
      highlightColor: highLightColor ?? Colors.grey.shade50,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: ShapeDecoration(shape: shapeBorder, color: AppColors.grey200),
      ),
    );
  }
}
