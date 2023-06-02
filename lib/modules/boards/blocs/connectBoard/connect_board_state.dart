part of 'connect_board_cubit.dart';

abstract class ConnectBoardState extends Equatable {
  const ConnectBoardState();

  @override
  List<Object?> get props => [];
}

class ConnectBoardInitial extends ConnectBoardState {}
class ConnectBoardInProgress extends ConnectBoardState {
  
}

class ConnectBoardSucceeded extends ConnectBoardState {
  final Board? board;
  

  const ConnectBoardSucceeded({
    required this.board,
  });

 

  @override
  List<Object?> get props => [board];
}

class ConnectBoardFailed extends ErrorState implements ConnectBoardState {
  const ConnectBoardFailed([Object? e]) : super(e);
}