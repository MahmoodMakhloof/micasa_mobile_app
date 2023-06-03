import 'package:utilities/utilities.dart';

class EventsNetworking {
  EventsNetworking._();
  // scence primary uri
  static Uri get _scenceUri => Network.siteUri.addSegment("/scence");

  static Uri get getMyScences => _scenceUri.addSegment("/getUserScences");
  static Uri get createScence => _scenceUri.addSegment("/create");

  // schedule primary uri
  static Uri get _scheduleUri => Network.siteUri.addSegment("/schedule");
  static Uri get getMySchedules => _scheduleUri.addSegment("/getUserSchedules");
  static Uri get createSchedule => _scheduleUri.addSegment("/create");

  // get output interfaces
  static Uri get getEventInterfaces =>
      Network.siteUri.addSegment("/interface/getOutputInterfaces");
}
