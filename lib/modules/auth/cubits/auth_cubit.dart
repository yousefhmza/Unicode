import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/utils/globals.dart';

import '../../../core/services/error/failure.dart';
import '../models/requests/auth_body.dart';
import '../repositories/auth_repository.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitialState());

  bool get isAuthed => _authRepository.isAuthed;

  Future<void> signup(AuthBody authBody) async {
    emit(AuthLoadingState());
    final result = await _authRepository.signup(authBody);
    result.fold(
      (failure) => emit(AuthFailureState(failure)),
      (user) {
        Global.instance.currentUser = user;
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> login(AuthBody authBody) async {
    emit(AuthLoadingState());
    final result = await _authRepository.login(authBody);
    result.fold(
      (failure) => emit(AuthFailureState(failure)),
      (user) {
        Global.instance.currentUser = user;
        emit(AuthSuccessState());
      },
    );
  }
}
