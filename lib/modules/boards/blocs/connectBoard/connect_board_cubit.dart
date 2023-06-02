import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/boards/models/board.dart';
import 'package:shca/modules/boards/repositories/boards_repository.dart';
import 'package:utilities/utilities.dart';

part 'connect_board_state.dart';

class ConnectBoardCubit extends Cubit<ConnectBoardState> {
  final BoardsRepository _boardsRepository;
  ConnectBoardCubit(this._boardsRepository) : super(ConnectBoardInitial());

  void connectBoard(String token) async {
    emit(ConnectBoardInProgress());
    try {
      var board = await _boardsRepository.connectBoard(token);
      emit(ConnectBoardSucceeded(board: board));
    } catch (e) {
      emit(ConnectBoardFailed(e));
    }
  }
}
