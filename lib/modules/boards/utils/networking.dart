import 'package:utilities/utilities.dart';

class BoardsNetworking {
  BoardsNetworking._();
  // board primary uri
  static Uri get _boardUri => Network.siteUri.addSegment("/board");
  static Uri get getMyBoards => _boardUri.addSegment("/getUserBoards");
  static Uri get connectBoard => _boardUri.addSegment("/connect");
  
}
