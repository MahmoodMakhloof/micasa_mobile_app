part of 'get_user_data_cubit.dart';

abstract class GetUserDataState extends Equatable {
  const GetUserDataState();

  @override
  List<Object?> get props => [];
}

class GetUserDataInitial extends GetUserDataState {}
class GetUserDataInProgress extends GetUserDataState {
}

class GetUserDataSucceeded extends GetUserDataState {
  final UserModel user;
  

  const GetUserDataSucceeded({
    required this.user,
  });

  @override
  String toString() => "GetUserDataSuccess(user: ${user.id})";

  @override
  List<Object> get props => [user];
}

class GetUserDataFailed extends ErrorState implements GetUserDataState {
  const GetUserDataFailed([Object? e]) : super(e);
}