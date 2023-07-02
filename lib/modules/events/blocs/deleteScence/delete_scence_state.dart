part of 'delete_scence_cubit.dart';

abstract class DeleteScenceState extends Equatable {
  const DeleteScenceState();

  @override
  List<Object?> get props => [];
}

class DeleteScenceInitial extends DeleteScenceState {}
class DeleteScenceInProgress extends DeleteScenceState {}

class DeleteScenceSucceeded extends DeleteScenceState {
 
}

class DeleteScenceFailed extends ErrorState implements DeleteScenceState {
  const DeleteScenceFailed([Object? e]) : super(e);
}