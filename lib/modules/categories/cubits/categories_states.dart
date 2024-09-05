part of 'categories_cubit.dart';

abstract class CategoriesStates {}

final class CategoriesInitialState extends CategoriesStates {}

class SyncRemoteDataLoadingState extends CategoriesStates {}

class SyncRemoteDataSuccessState extends CategoriesStates {}

class SyncRemoteDataFailureState extends CategoriesStates {
  final Failure failure;

  SyncRemoteDataFailureState(this.failure);
}

class AddCategoryFailureState extends CategoriesStates {
  final Failure failure;

  AddCategoryFailureState(this.failure);
}

class DeleteCategoryFailureState extends CategoriesStates {
  final Failure failure;

  DeleteCategoryFailureState(this.failure);
}

class DeleteCategorySuccessState extends CategoriesStates {
  final int index;
  final CategoryModel category;

  DeleteCategorySuccessState(this.index, this.category);
}

class GetCategoriesFailureState extends CategoriesStates {
  final Failure failure;

  GetCategoriesFailureState(this.failure);
}
