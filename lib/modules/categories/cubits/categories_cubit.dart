import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/services/error/failure.dart';
import 'package:unicode/modules/categories/models/category_model.dart';
import 'package:unicode/modules/categories/repositories/categories_repository.dart';

import '../../../core/resources/app_values.dart';

part 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepository _categoriesRepository;

  CategoriesCubit(this._categoriesRepository) : super(CategoriesInitialState());

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<CategoryModel> categories = [];

  Future<void> syncRemoteData() async {
    emit(SyncRemoteDataLoadingState());
    final result = await _categoriesRepository.syncRemoteData();
    result.fold(
      (failure) => emit(SyncRemoteDataFailureState(failure)),
      (_) {
        emit(SyncRemoteDataSuccessState());
      },
    );
  }

  Future<void> getAllCategories() async {
    final result = await _categoriesRepository.getAllCategories();
    result.fold(
      (failure) => emit(GetCategoriesFailureState(failure)),
      (categories) {
        for (int i = 0; i < categories.length; i++) {
          Future.delayed(Duration(milliseconds: 100 * i), () {
            this.categories.add(categories[i]);
            listKey.currentState?.insertItem(this.categories.length - 1, duration: Time.t700ms);
          });
        }
      },
    );
  }

  Future<void> addCategory(String name, String color) async {
    final result = await _categoriesRepository.addCategory(name, color);
    result.fold(
      (failure) => emit(AddCategoryFailureState(failure)),
      (category) {
        categories.add(category);
        listKey.currentState?.insertItem(categories.length - 1, duration: Time.t700ms);
      },
    );
  }

  Future<void> deleteCategory(String categoryId) async {
    final result = await _categoriesRepository.deleteCategory(categoryId);
    result.fold(
      (failure) => emit(DeleteCategoryFailureState(failure)),
      (_) {
        final index = categories.indexWhere((category) => category.id == categoryId);
        final category = categories.removeAt(index);
        emit(DeleteCategorySuccessState(index, category));
      },
    );
  }

  void reset(){
    categories.clear();
  }
}
