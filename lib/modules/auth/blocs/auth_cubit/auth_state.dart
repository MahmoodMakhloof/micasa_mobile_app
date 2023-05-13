part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthInProgress extends AuthState {
  
}

class AuthSucceeded extends AuthState {
  final User? user;
  

  const AuthSucceeded({
    required this.user,
  });

  @override
  String toString() => "AuthSuccess(user: ${user!.uid})";

  @override
  List<Object?> get props => [user];
}

class AuthFailed extends ErrorState implements AuthState {
  const AuthFailed([Object? e]) : super(e);
}
