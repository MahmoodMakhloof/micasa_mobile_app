part of 'fetch_boards_cubit.dart';

abstract class FetchBoardsState extends Equatable {
  const FetchBoardsState();

  @override
  List<Object?> get props => [];
}

class FetchBoardsInitial extends FetchBoardsState {}
class FetchBoardsInProgress extends FetchBoardsState {
  
}

class FetchBoardsSucceeded extends FetchBoardsState {
  final List<Board> boards;
  

  const FetchBoardsSucceeded({
    required this.boards,
  });

 

  @override
  List<Object?> get props => [boards];
}

class FetchBoardsFailed extends ErrorState implements FetchBoardsState {
  const FetchBoardsFailed([Object? e]) : super(e);
}
