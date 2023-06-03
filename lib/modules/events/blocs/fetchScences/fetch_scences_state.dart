part of 'fetch_scences_cubit.dart';

abstract class FetchScencesState extends Equatable {
  const FetchScencesState();

  @override
  List<Object?> get props => [];
}

class FetchScencesInitial extends FetchScencesState {}
class FetchScencesInProgress extends FetchScencesState {
  
}

class FetchScencesSucceeded extends FetchScencesState {
  final List<Scence> scences;
  

  const FetchScencesSucceeded({
    required this.scences,
  });

 

  @override
  List<Object?> get props => [scences];
}

class FetchScencesFailed extends ErrorState implements FetchScencesState {
  const FetchScencesFailed([Object? e]) : super(e);
}
