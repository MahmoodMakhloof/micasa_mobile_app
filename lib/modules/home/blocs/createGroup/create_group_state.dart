part of 'create_group_cubit.dart';

abstract class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object?> get props => [];
}

class CreateGroupInitial extends CreateGroupState {}
class CreateGroupInProgress extends CreateGroupState {
  
}

class CreateGroupSucceeded extends CreateGroupState {
  final Group group;
  

  const CreateGroupSucceeded({
    required this.group,
  });

 

  @override
  List<Object?> get props => [group];
}

class CreateGroupFailed extends ErrorState implements CreateGroupState {
  const CreateGroupFailed([Object? e]) : super(e);
}
