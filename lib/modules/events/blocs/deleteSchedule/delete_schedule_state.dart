part of 'delete_schedule_cubit.dart';

abstract class DeleteScheduleState extends Equatable {
  const DeleteScheduleState();

  @override
  List<Object?> get props => [];
}

class DeleteScheduleInitial extends DeleteScheduleState {}

class DeleteScheduleInProgress extends DeleteScheduleState {}

class DeleteScheduleSucceeded extends DeleteScheduleState {
 
}

class DeleteScheduleFailed extends ErrorState implements DeleteScheduleState {
  const DeleteScheduleFailed([Object? e]) : super(e);
}
