import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/services/error/failure.dart';
import 'package:unicode/modules/todos/models/todo_model.dart';
import 'package:unicode/modules/todos/repositories/todos_repository.dart';

import '../../../core/resources/app_values.dart';

part 'todos_states.dart';

class TodosCubit extends Cubit<TodosStates> {
  final TodosRepository _todosRepository;

  TodosCubit(this._todosRepository) : super(TodosInitialState());

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Todo> todos = [];

  Future<void> getTodos(String categoryId) async {
    todos.clear();
    final result = await _todosRepository.getTodos(categoryId: categoryId);
    result.fold(
      (failure) => emit(GetTodosFailureState(failure)),
      (todos) {
        for (int i = 0; i < todos.length; i++) {
          Future.delayed(Duration(milliseconds: 100 * i), () {
            this.todos.add(todos[i]);
            listKey.currentState?.insertItem(this.todos.length - 1, duration: Time.t300ms);
          });
        }
      },
    );
  }

  Future<void> addTodo({required String categoryId, required String title, required String desc}) async {
    final result = await _todosRepository.addTodo(categoryId, title, desc);
    result.fold(
      (failure) => emit(AddTodoFailureState(failure)),
      (todo) {
        todos.add(todo);
        listKey.currentState?.insertItem(todos.length - 1, duration: Time.t300ms);
      },
    );
  }

  Future<void> deleteTodo(String todoId) async {
    final result = await _todosRepository.deleteTodo(todoId);
    result.fold(
      (failure) => emit(DeleteTodoFailureState(failure)),
      (_) {
        final index = todos.indexWhere((todo) => todo.id == todoId);
        final todo = todos.removeAt(index);
        emit(DeleteTodoSuccessState(index, todo));
      },
    );
  }
}
