import 'package:utilities/utilities.dart';

class SchedulesNetworking {
  SchedulesNetworking._();
  // schedule primary uri
  static Uri get _scheduleUri => Network.siteUri.addSegment("/schedule");
  static Uri get getMySchedules => _scheduleUri.addSegment("/getUserSchedules");
}
