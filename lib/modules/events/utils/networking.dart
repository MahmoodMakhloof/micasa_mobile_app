import 'package:utilities/utilities.dart';

class EventsNetworking {
  EventsNetworking._();
  // scence primary uri
  static Uri get _scenceUri => Network.siteUri.addSegment("/scence");

  static Uri get getMyScences => _scenceUri.addSegment("/getUserScences");
  static Uri get createScence => _scenceUri.addSegment("/create");
  static Uri get updateScence => _scenceUri.addSegment("/update");
  static Uri get deleteScence => _scenceUri.addSegment("/delete");

  // schedule primary uri
  static Uri get _scheduleUri => Network.siteUri.addSegment("/schedule");
  static Uri get getMySchedules => _scheduleUri.addSegment("/getUserSchedules");
  static Uri get createSchedule => _scheduleUri.addSegment("/create");
  static Uri get updateSchedule => _scheduleUri.addSegment("/update");
  static Uri get deleteSchedule => _scheduleUri.addSegment("/delete");

  // get output interfaces
  static Uri get getEventInterfaces =>
      Network.siteUri.addSegment("/interface/getOutputInterfaces");
}
