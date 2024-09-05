import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/modules/categories/models/category_model.dart';
import 'package:unicode/modules/todos/cubits/todos_cubit.dart';

import '../../../../config/navigation/navigation.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/view/views.dart';
import '../../../../config/localization/l10n/l10n.dart';

class AddTodoSheet extends StatefulWidget {
  final CategoryModel category;

  const AddTodoSheet({required this.category, super.key});

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  late final TodosCubit todosCubit;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController titleController;
  late final TextEditingController descController;

  @override
  void initState() {
    super.initState();
    todosCubit = BlocProvider.of<TodosCubit>(context);
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(L10n.tr(context).addTodo, fontSize: FontSize.s18, fontWeight: FontWeightManager.bold),
          const VerticalSpace(AppSize.s4),
          CustomText(L10n.tr(context).addTodDesc, color: AppColors.grey600, fontSize: FontSize.s16),
          const VerticalSpace(AppSize.s16),
          CustomTextField(
            hintText: L10n.tr(context).title,
            controller: titleController,
            validator: Validators.notEmptyValidator,
          ),
          const VerticalSpace(AppSize.s8),
          CustomTextField(
            hintText: L10n.tr(context).description,
            controller: descController,
            minLines: 5,
            maxLines: 5,
            validator: Validators.notEmptyValidator,
          ),
          const VerticalSpace(AppSize.s16),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomButton(
              padding: AppEdgeInsets.symmetric(horizontal: AppPadding.p32, vertical: AppPadding.p6),
              text: L10n.tr(context).add,
              onPressed: () async {
                if (!formKey.currentState!.validate() ||
                    titleController.text.trim().isEmpty ||
                    descController.text.trim().isEmpty) return;
                NavigationService.goBack();
                await Future.delayed(Time.t300ms);
                todosCubit.addTodo(
                  categoryId: widget.category.id,
                  title: titleController.text.trim(),
                  desc: descController.text.trim(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
