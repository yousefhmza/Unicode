import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/config/navigation/navigation.dart';
import 'package:unicode/core/extensions/color_extension.dart';
import 'package:unicode/core/utils/dialogs.dart';
import 'package:unicode/modules/categories/cubits/categories_cubit.dart';
import 'package:unicode/modules/categories/models/category_model.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';
import '../../../../config/localization/l10n/l10n.dart';

class CategoryItem extends StatelessWidget {
  final Animation<double> animation;
  final CategoryModel category;

  const CategoryItem({required this.animation, required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      key: ValueKey(category.id),
      position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
        CurvedAnimation(parent: animation, curve: const ElasticOutCurve(0.8)),
      ),
      child: GestureDetector(
        onTap: () => NavigationService.push(Routes.todosScreen, arguments: {"category": category}),
        child: Container(
          margin: AppEdgeInsets.only(bottom: AppPadding.p16),
          clipBehavior: Clip.antiAlias,
          foregroundDecoration: BoxDecoration(borderRadius: AppBorderRadius.all(AppSize.s8)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppBorderRadius.all(AppSize.s8),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.15),
                blurRadius: AppSize.s8,
                offset: const Offset(AppSize.s0, AppSize.s4),
              )
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(color: category.color.toColor(), width: AppSize.s5),
                Expanded(
                  child: Padding(
                    padding: AppEdgeInsets.all(AppPadding.p12),
                    child: Row(
                      children: [
                        Expanded(child: CustomText(category.name)),
                        GestureDetector(
                          onTap: () => AppDialogs.showAnimatedDialog(
                            context,
                            ConfirmationDialog(
                              title: L10n.tr(context).deleteCategoryWarning,
                              onConfirm: () => BlocProvider.of<CategoriesCubit>(context).deleteCategory(category.id),
                            ),
                          ),
                          child: CustomIcon(Icons.delete, color: AppColors.warning),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
