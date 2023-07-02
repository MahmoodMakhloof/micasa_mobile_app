part of 'update_schedule_cubit.dart';

abstract class UpdateScheduleState extends Equatable {
  const UpdateScheduleState();

  @override
  List<Object?> get props => [];
}

class UpdateScheduleInitial extends UpdateScheduleState {}
class UpdateScheduleInProgress extends UpdateScheduleState {
  
}

class UpdateScheduleSucceeded extends UpdateScheduleState {
  final  Schedule schedule;
  

  const UpdateScheduleSucceeded({
    required this.schedule,
  });

 

  @override
  List<Object?> get props => [schedule];
}

class UpdateScheduleFailed extends ErrorState implements UpdateScheduleState {
  const UpdateScheduleFailed([Object? e]) : super(e);
}
