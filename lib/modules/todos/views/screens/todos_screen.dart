import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/utils/sheets.dart';
import 'package:unicode/modules/categories/models/category_model.dart';
import 'package:unicode/modules/todos/cubits/todos_cubit.dart';
import 'package:unicode/modules/todos/views/components/add_todo_sheet.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';
import '../widgets/todo_item.dart';

class TodosScreen extends StatefulWidget {
  final CategoryModel category;

  const TodosScreen({required this.category, super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late final TodosCubit todosCubit;

  @override
  void initState() {
    super.initState();
    todosCubit = BlocProvider.of<TodosCubit>(context);
    todosCubit.getTodos(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          CustomSliverAppbar(
            title: widget.category.name,
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () => AppSheets.showBottomSheet(context, child: AddTodoSheet(category: widget.category)),
                child: CustomIcon(Icons.add_circle, size: AppSize.s32),
              ),
              HorizontalSpace(AppSize.s12),
            ],
          ),
        ],
        body: BlocListener<TodosCubit, TodosStates>(
          listener: (context, state) {
            if (state is DeleteTodoSuccessState) {
              Future.delayed(
                Time.t500ms,
                () {
                  todosCubit.listKey.currentState!.removeItem(
                    state.index,
                    (context, animation) => TodoItem(animation: animation, todo: state.todo),
                    duration: Time.t300ms,
                  );
                },
              );
            }
          },
          child: AnimatedList(
            key: todosCubit.listKey,
            padding: AppEdgeInsets.all(AppPadding.p12),
            initialItemCount: todosCubit.todos.length,
            itemBuilder: (context, index, animation) => TodoItem(animation: animation, todo: todosCubit.todos[index]),
          ),
        ),
      ),
    );
  }
}
