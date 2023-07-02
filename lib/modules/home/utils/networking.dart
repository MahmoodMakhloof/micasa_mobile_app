import 'package:utilities/utilities.dart';

import '../blocs/fetchInterfaces/fetch_interfaces_cubit.dart';

class HomeNetworking {
  HomeNetworking._();
  // group primary uri
  static Uri get _groupUri => Network.siteUri.addSegment("/group");
  static Uri get getMyGroups => _groupUri.addSegment("/getUserGroups");
  static Uri getGroupInterfaces(String id) =>
      _groupUri.addSegment('/$id/interfaces');
  static Uri get createNewGroup => _groupUri.addSegment("/create");
  static Uri get addUserToGroup => _groupUri.addSegment("/addUser");
  static Uri get fireUserFromGroup => _groupUri.addSegment("/fireUser");
  static Uri get updateGroup => _groupUri.addSegment("/update");
  static Uri get deleteGroup => _groupUri.addSegment("/delete");
  static Uri get addInterfacesToGroup => _groupUri.addSegment("/add");
  static Uri get removeInterfaceToGroup => _groupUri.addSegment("/remove");
  static Uri get getGroupPics => _groupUri.addSegment("/pics");

  // interface primary uri
  static Uri get _interfaceUri => Network.siteUri.addSegment("/interface");
  static Future<Uri> getMyInterfaces(
      {required InterfacesScope scope,
      String? text,
      String? groupId,
      String? boardId}) async {
    List<QueryParam> querys = [];
    querys.add(QueryParam(param: "text", value: text ?? ''));
    if (groupId != null) {
      querys.add(QueryParam(param: "groupId", value: groupId));
    }
    if (boardId != null) {
      querys.add(QueryParam(param: "boardId", value: boardId));
    }
    return _interfaceUri.addSegment("/getUserInterfaces").addQueryParams(
        [QueryParam(param: "scope", value: scope.toStr()), ...querys]);
  }
}
