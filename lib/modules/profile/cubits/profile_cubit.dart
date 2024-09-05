import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/utils/globals.dart';
import 'package:unicode/modules/auth/repositories/auth_repository.dart';
import 'package:unicode/modules/categories/repositories/categories_repository.dart';
import 'package:unicode/modules/profile/repositories/profile_repository.dart';
import 'package:unicode/modules/todos/repositories/todos_repository.dart';

import '../../../core/services/error/failure.dart';

part 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepository _profileRepository;
  final CategoriesRepository _categoriesRepository;
  final TodosRepository _todosRepository;
  final AuthRepository _authRepository;

  ProfileCubit(
    this._profileRepository,
    this._categoriesRepository,
    this._todosRepository,
    this._authRepository,
  ) : super(ProfileInitialState());

  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoadingState());
    final result = await _profileRepository.getCurrentUser();
    result.fold(
      (failure) => emit(GetCurrentUserFailureState(failure)),
      (user) {
        Global.instance.currentUser = user;
        emit(GetCurrentUserSuccessState());
      },
    );
  }

  Future<void> syncCategories({required bool logoutAfterDone}) async {
    emit(SyncCategoriesLoadingState());
    final result = await _categoriesRepository.synchronizeCategories();
    result.fold(
      (failure) => emit(SyncCategoriesFailureState(failure)),
      (_) => emit(SyncCategoriesSuccessState(logoutAfterDone: logoutAfterDone)),
    );
  }

  Future<void> syncTodos({required bool logoutAfterDone}) async {
    emit(SyncTodosLoadingState());
    final result = await _todosRepository.synchronizeTodos();
    result.fold(
      (failure) => emit(SyncTodosFailureState(failure)),
      (_) => emit(SyncTodosSuccessState(logoutAfterDone: logoutAfterDone)),
    );
  }

  Future<void> logout() async {
    final result = await _authRepository.logout();
    result.fold(
      (failure) => emit(LogoutFailureState(failure)),
      (_) {
        Global.instance.currentUser = null;
        emit(LogoutSuccessState());
      },
    );
  }
}
