import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/config/navigation/navigation.dart';
import 'package:unicode/core/extensions/color_extension.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/core/utils/utils.dart';
import 'package:unicode/core/utils/validators.dart';
import 'package:unicode/core/view/views.dart';

import '../../../../config/localization/l10n/l10n.dart';
import '../../cubits/categories_cubit.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  late final CategoriesCubit categoriesCubit;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    formKey = GlobalKey<FormState>();
    categoryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.all(AppSize.s16)),
      child: Padding(
        padding: AppEdgeInsets.all(AppPadding.p12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(L10n.tr(context).enterCategoryName, fontSize: FontSize.s16),
                  ),
                  GestureDetector(
                    onTap: () => NavigationService.goBack(),
                    child: Container(
                      padding: AppEdgeInsets.all(AppPadding.p4),
                      decoration: const ShapeDecoration(color: AppColors.grey200, shape: CircleBorder()),
                      child: const CustomIcon(Icons.close),
                    ),
                  )
                ],
              ),
              const VerticalSpace(AppSize.s16),
              CustomTextField(
                hintText: L10n.tr(context).category,
                controller: categoryController,
                validator: Validators.notEmptyValidator,
              ),
              const VerticalSpace(AppSize.s16),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomButton(
                  padding: AppEdgeInsets.symmetric(horizontal: AppPadding.p32, vertical: AppPadding.p6),
                  text: L10n.tr(context).add,
                  onPressed: () async {
                    if (!formKey.currentState!.validate() || categoryController.text.trim().isEmpty) return;
                    NavigationService.goBack();
                    await Future.delayed(Time.t500ms);
                    categoriesCubit.addCategory(categoryController.text.trim(), Utils.randomColor.toHex());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
