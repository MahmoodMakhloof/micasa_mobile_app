part of 'create_scence_cubit.dart';

abstract class CreateScenceState extends Equatable {
  const CreateScenceState();

  @override
  List<Object?> get props => [];
}

class CreateScenceInitial extends CreateScenceState {}
class CreateScenceInProgress extends CreateScenceState {
  
}

class CreateScenceSucceeded extends CreateScenceState {
  final  Scence scence;
  

  const CreateScenceSucceeded({
    required this.scence,
  });

 

  @override
  List<Object?> get props => [scence];
}

class CreateScenceFailed extends ErrorState implements CreateScenceState {
  const CreateScenceFailed([Object? e]) : super(e);
}
