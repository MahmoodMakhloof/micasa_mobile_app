import 'package:dio/dio.dart';
import 'package:shca/modules/boards/models/board.dart';
import 'package:shca/modules/boards/utils/networking.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/auth.dart';
import '../../../core/helpers/networking.dart';

class BoardsRepository {
  final Dio _client;
  BoardsRepository({Dio? client}) : _client = client ?? Dio();

  Future<List<Board>> fetchMyBoards() async {
    try {
      final uri = BoardsNetworking.getMyBoards;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['boards'] as List;
      final boards = data.map((element) => Board.fromJson(element)).toList();
      return boards;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<Board> connectBoard(String token) async {
    try {
      final uri = BoardsNetworking.connectBoard;
      final customOptions = await getCustomOptions();
      final response = await _client.patchUri(
        uri,
        data: {"token": token},
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['board'];
      final board = Board.fromJson(data);
      return board;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }
}
