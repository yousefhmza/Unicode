part of 'profile_cubit.dart';

abstract class ProfileStates {}

final class ProfileInitialState extends ProfileStates {}

class GetCurrentUserLoadingState extends ProfileStates {}

class GetCurrentUserSuccessState extends ProfileStates {}

class GetCurrentUserFailureState extends ProfileStates {
  final Failure failure;

  GetCurrentUserFailureState(this.failure);
}

class SyncCategoriesLoadingState extends ProfileStates {}

class SyncCategoriesSuccessState extends ProfileStates {
  final bool logoutAfterDone;

  SyncCategoriesSuccessState({required this.logoutAfterDone});
}

class SyncCategoriesFailureState extends ProfileStates {
  final Failure failure;

  SyncCategoriesFailureState(this.failure);
}

class SyncTodosLoadingState extends ProfileStates {}

class SyncTodosSuccessState extends ProfileStates {
  final bool logoutAfterDone;

  SyncTodosSuccessState({required this.logoutAfterDone});
}

class SyncTodosFailureState extends ProfileStates {
  final Failure failure;

  SyncTodosFailureState(this.failure);
}

class LogoutSuccessState extends ProfileStates {}

class LogoutFailureState extends ProfileStates {
  final Failure failure;

  LogoutFailureState(this.failure);
}
