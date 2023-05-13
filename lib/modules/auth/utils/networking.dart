import 'package:utilities/utilities.dart';

class AuthNetworking {
  AuthNetworking._();
  // primary uri
  static Uri get _userUri => Network.siteUri.addSegment("/user");
  
  static Uri get createNewUserUri => _userUri.addSegment("/create");
  static Uri get getUserDataUri => _userUri.addSegment("/get");
}
