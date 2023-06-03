part of 'fetch_event_intefaces_cubit.dart';

abstract class FetchEventIntefacesState extends Equatable {
  const FetchEventIntefacesState();

  @override
  List<Object?> get props => [];
}

class FetchEventIntefacesInitial extends FetchEventIntefacesState {}
class FetchEventIntefacesInProgress extends FetchEventIntefacesState {
  
}

class FetchEventIntefacesSucceeded extends FetchEventIntefacesState {
  final List<EventInterface> interfaces;
  

  const FetchEventIntefacesSucceeded({
    required this.interfaces,
  });

 

  @override
  List<Object?> get props => [interfaces];
}

class FetchEventIntefacesFailed extends ErrorState implements FetchEventIntefacesState {
  const FetchEventIntefacesFailed([Object? e]) : super(e);
}
