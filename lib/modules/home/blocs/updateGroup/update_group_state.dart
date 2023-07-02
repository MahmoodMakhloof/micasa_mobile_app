part of 'update_group_cubit.dart';

abstract class UpdateGroupState extends Equatable {
  const UpdateGroupState();

  @override
  List<Object?> get props => [];
}

class UpdateGroupInitial extends UpdateGroupState {}
class UpdateGroupInProgress extends UpdateGroupState {
  
}

class UpdateGroupSucceeded extends UpdateGroupState {
  final Group group;
  

  const UpdateGroupSucceeded({
    required this.group,
  });

 

  @override
  List<Object?> get props => [group];
}

class UpdateGroupFailed extends ErrorState implements UpdateGroupState {
  const UpdateGroupFailed([Object? e]) : super(e);
}
