part of 'create_schedule_cubit.dart';

abstract class CreateScheduleState extends Equatable {
  const CreateScheduleState();

  @override
  List<Object?> get props => [];
}

class CreateScheduleInitial extends CreateScheduleState {}
class CreateScheduleInProgress extends CreateScheduleState {
  
}

class CreateScheduleSucceeded extends CreateScheduleState {
  final  Schedule schedule;
  

  const CreateScheduleSucceeded({
    required this.schedule,
  });

 

  @override
  List<Object?> get props => [schedule];
}

class CreateScheduleFailed extends ErrorState implements CreateScheduleState {
  const CreateScheduleFailed([Object? e]) : super(e);
}
