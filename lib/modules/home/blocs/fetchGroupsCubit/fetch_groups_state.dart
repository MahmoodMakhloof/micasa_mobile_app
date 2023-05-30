part of 'fetch_groups_cubit.dart';

abstract class FetchGroupsState extends Equatable {
  const FetchGroupsState();

  @override
  List<Object?> get props => [];
}

class FetchGroupsInitial extends FetchGroupsState {}
class FetchGroupsInProgress extends FetchGroupsState {
  
}

class FetchGroupsSucceeded extends FetchGroupsState {
  final List<Group>? groups;
  

  const FetchGroupsSucceeded({
    required this.groups,
  });

 

  @override
  List<Object?> get props => [groups];
}

class FetchGroupsFailed extends ErrorState implements FetchGroupsState {
  const FetchGroupsFailed([Object? e]) : super(e);
}
