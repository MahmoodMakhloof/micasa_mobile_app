import 'package:utilities/utilities.dart';

class ScencesNetworking {
  ScencesNetworking._();
  // scence primary uri
  static Uri get _scenceUri => Network.siteUri.addSegment("/scence");
  static Uri get getMyScences => _scenceUri.addSegment("/getUserScences");
}
