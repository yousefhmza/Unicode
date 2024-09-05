part of 'auth_cubit.dart';

abstract class AuthStates {}

final class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthFailureState extends AuthStates {
  final Failure failure;

  AuthFailureState(this.failure);
}
