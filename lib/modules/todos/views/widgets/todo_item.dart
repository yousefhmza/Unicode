import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/modules/todos/cubits/todos_cubit.dart';
import 'package:unicode/modules/todos/models/todo_model.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/view/views.dart';
import '../../../../config/localization/l10n/l10n.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Animation<double> animation;

  const TodoItem({required this.animation, required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      key: ValueKey(todo.id),
      sizeFactor: animation,
      child: Container(
        margin: AppEdgeInsets.only(bottom: AppPadding.p16),
        padding: AppEdgeInsets.all(AppPadding.p12),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: CustomText(todo.title)),
                HorizontalSpace(AppSize.s4),
                GestureDetector(
                  onTap: () => AppDialogs.showAnimatedDialog(
                    context,
                    ConfirmationDialog(
                      title: L10n.tr(context).deleteTodoWarning,
                      onConfirm: () => BlocProvider.of<TodosCubit>(context).deleteTodo(todo.id),
                    ),
                  ),
                  child: CustomIcon(Icons.delete, color: AppColors.warning),
                )
              ],
            ),
            VerticalSpace(AppSize.s4),
            CustomText(todo.description, color: AppColors.grey500, fontSize: FontSize.s12),
          ],
        ),
      ),
    );
  }
}
