import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utilities/utilities.dart';

import '../../repositories/authentication_repository_impl.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _authenticationRepository;
  AuthCubit(this._authenticationRepository) : super(AuthInitialState());


  signInWithGoogle() async {
    emit( AuthInProgress());
    try {
      final user = await _authenticationRepository.signInWithGoogle();
      emit(AuthSucceeded(user: user));
    } catch (e) {
      emit(AuthFailed(e));
    }
  }
}
