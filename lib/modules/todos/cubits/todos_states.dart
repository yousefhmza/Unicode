part of 'todos_cubit.dart';

abstract class TodosStates {}

final class TodosInitialState extends TodosStates {}

class AddTodoFailureState extends TodosStates {
  final Failure failure;

  AddTodoFailureState(this.failure);
}

class DeleteTodoFailureState extends TodosStates {
  final Failure failure;

  DeleteTodoFailureState(this.failure);
}

class DeleteTodoSuccessState extends TodosStates {
  final int index;
  final Todo todo;

  DeleteTodoSuccessState(this.index, this.todo);
}

class GetTodosFailureState extends TodosStates {
  final Failure failure;

  GetTodosFailureState(this.failure);
}
