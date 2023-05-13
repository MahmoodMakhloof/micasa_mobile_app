import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shca/Views/root.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/modules/auth/models/user.dart';
import 'package:shca/modules/auth/views/auth_view.dart';
import 'package:utilities/utilities.dart';

import '../../repositories/authentication_repository_impl.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  final AuthenticationRepository _authenticationRepository;
  GetUserDataCubit(this._authenticationRepository)
      : super(GetUserDataInitial());

  Future<void> getUserData() async {
    emit( GetUserDataInProgress());
    try {
      final me = await _authenticationRepository.getUserData();
      emit(GetUserDataSucceeded(user: me));
    } catch (e) {
      emit(GetUserDataFailed(e));
      _tryCreateUserAgain();
    }
  }

  _tryCreateUserAgain() async {
    emit( GetUserDataInProgress());
    try {
      final userData = FirebaseAuth.instance.currentUser;
      final me = await _authenticationRepository.createNewUser(UserModel(
          email: userData!.email,
          fullname: userData.displayName,
          avatar: userData.photoURL));
      emit(GetUserDataSucceeded(user: me));
    } catch (e) {
      emit(GetUserDataFailed(e));
    }
  }

  listenAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        NavigationService.context!.navigateForward(const AuthView());
      } else {
        // getUserData
        getUserData();
        NavigationService.context!.navigateForward(const Root());
      }
    });
  }
}
