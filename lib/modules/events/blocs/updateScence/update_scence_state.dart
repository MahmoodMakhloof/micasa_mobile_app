part of 'update_scence_cubit.dart';

abstract class UpdateScenceState extends Equatable {
  const UpdateScenceState();

  @override
  List<Object?> get props => [];
}

class UpdateScenceInitial extends UpdateScenceState {}
class UpdateScenceInProgress extends UpdateScenceState {
  
}

class UpdateScenceSucceeded extends UpdateScenceState {
  final  Scence scence;
  

  const UpdateScenceSucceeded({
    required this.scence,
  });

 

  @override
  List<Object?> get props => [scence];
}

class UpdateScenceFailed extends ErrorState implements UpdateScenceState {
  const UpdateScenceFailed([Object? e]) : super(e);
}
