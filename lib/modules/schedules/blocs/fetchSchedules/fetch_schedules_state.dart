part of 'fetch_schedules_cubit.dart';

abstract class FetchSchedulesState extends Equatable {
  const FetchSchedulesState();

  @override
  List<Object?> get props => [];
}

class FetchSchedulesInitial extends FetchSchedulesState {}
class FetchSchedulesInProgress extends FetchSchedulesState {
  
}

class FetchSchedulesSucceeded extends FetchSchedulesState {
  final List<Schedule>? schedules;
  

  const FetchSchedulesSucceeded({
    required this.schedules,
  });

 

  @override
  List<Object?> get props => [schedules];
}

class FetchSchedulesFailed extends ErrorState implements FetchSchedulesState {
  const FetchSchedulesFailed([Object? e]) : super(e);
}
