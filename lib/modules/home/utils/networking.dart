import 'package:utilities/utilities.dart';

class HomeNetworking {
  HomeNetworking._();
  // group primary uri
  static Uri get _groupUri => Network.siteUri.addSegment("/group");
  static Uri get getMyGroups => _groupUri.addSegment("/getUserGroups");
  static Uri get createNewGroup => _groupUri.addSegment("/create");
  static Uri get addUserToGroup => _groupUri.addSegment("/addUser");
  static Uri get fireUserFromGroup => _groupUri.addSegment("/fireUser");
  static Uri get updateGroup => _groupUri.addSegment("/update");
  static Uri get deleteGroup => _groupUri.addSegment("/delete");
  static Uri get addInterfaceToGroup => _groupUri.addSegment("/add");
  static Uri get removeInterfaceToGroup => _groupUri.addSegment("/remove");

  // interface primary uri
  static Uri get _interfaceUri => Network.siteUri.addSegment("/interface");
  static Uri get getMyInterfaces =>
      _interfaceUri.addSegment("/getUserInterfaces");
}
