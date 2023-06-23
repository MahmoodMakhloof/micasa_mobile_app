import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/boards/models/board.dart';
import 'package:shca/modules/boards/repositories/boards_repository.dart';
import 'package:utilities/utilities.dart';
part 'fetch_boards_state.dart';

class FetchBoardsCubit extends Cubit<FetchBoardsState> {
  final BoardsRepository _boardsRepository;
  FetchBoardsCubit(this._boardsRepository) : super(FetchBoardsInitial());

  void fetchBoards() async {
    emit(FetchBoardsInProgress());

    try {
      var boards = await _boardsRepository.fetchMyBoards();
      emit(FetchBoardsSucceeded(boards: boards));
    } catch (e) {
      emit(FetchBoardsFailed(e));
    }
  }
}
