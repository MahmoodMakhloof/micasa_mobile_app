part of 'add_interfaces_to_group_cubit.dart';

abstract class AddInterfacesToGroupState extends Equatable {
  const AddInterfacesToGroupState();

  @override
  List<Object?> get props => [];
}

class AddInterfacesToGroupInitial extends AddInterfacesToGroupState {}
class AddInterfacesToGroupInProgress extends AddInterfacesToGroupState {}

class AddInterfacesToGroupSucceeded extends AddInterfacesToGroupState {
  final Group group;

  const AddInterfacesToGroupSucceeded({
    required this.group,
  });

  @override
  List<Object?> get props => [group];
}

class AddInterfacesToGroupFailed extends ErrorState implements AddInterfacesToGroupState {
  const AddInterfacesToGroupFailed([Object? e]) : super(e);
}
