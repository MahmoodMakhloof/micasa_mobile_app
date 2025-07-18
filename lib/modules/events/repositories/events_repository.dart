import 'package:dio/dio.dart';
import 'package:shca/modules/events/models/event_interface.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/modules/events/models/schedule.dart';
import 'package:shca/modules/events/utils/networking.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/auth.dart';
import '../../../core/helpers/networking.dart';

class EventsRepository {
  final Dio _client;

  EventsRepository({Dio? client}) : _client = client ?? Dio();

  Future<List<Scence>> fetchScences() async {
    try {
      final uri = EventsNetworking.getMyScences;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['scences'] as List;
      final scences = data.map((element) => Scence.fromJson(element)).toList();
      return scences;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<Scence> createNewScence(
      {required String name,
      required List<Event> events}) async {
    try {
      final uri = EventsNetworking.createScence;
      final customOptions = await getCustomOptions();
      final response = await _client.postUri(
        uri,
        data: {
          "name": name,
          "events": (events.map((e) => e.toJson()).toList())
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['scence'];
      final scence = Scence.fromJson(data);
      return scence;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

   Future<Scence> updateScence({required Scence newScence}) async {
    try {
      final uri = EventsNetworking.updateScence;
      final customOptions = await getCustomOptions();
      final response = await _client.patchUri(
        uri,
        data: {
          "scenceId": newScence.id,
          "name": newScence.name,
          "events": (newScence.events.map((e) => e.toJson()).toList())
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['scence'];
      final scence = Scence.fromJson(data);
      return scence;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<void> deleteScence({required Scence scence}) async {
    try {
      final uri = EventsNetworking.deleteScence;
      final customOptions = await getCustomOptions();
      await _client.deleteUri(
        uri,
        data: {
          "scenceId": scence.id,
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<Schedule> createNewSchedule(
      {required String name,
      required String? datetime,
      required String? cron,
      required List<Event> events}) async {
    try {
      final uri = EventsNetworking.createSchedule;
      final customOptions = await getCustomOptions();
      final response = await _client.postUri(
        uri,
        data: {
          "name": name,
          "cron": cron,
          "datetime": datetime,
          "events": (events.map((e) => e.toJson()).toList())
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['schedule'];
      final schedule = Schedule.fromJson(data);
      return schedule;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<Schedule> updateSchedule({required Schedule newSchedule}) async {
    try {
      final uri = EventsNetworking.updateSchedule;
      final customOptions = await getCustomOptions();
      final response = await _client.patchUri(
        uri,
        data: {
          "scheduleId": newSchedule.id,
          "enabled": newSchedule.enabled,
          "name": newSchedule.name,
          "cron": newSchedule.cron,
          "datetime": newSchedule.datetime,
          "events": (newSchedule.events.map((e) => e.toJson()).toList())
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['schedule'];
      final schedule = Schedule.fromJson(data);
      return schedule;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<void> deleteSchedule({required Schedule schedule}) async {
    try {
      final uri = EventsNetworking.deleteSchedule;
      final customOptions = await getCustomOptions();
      await _client.deleteUri(
        uri,
        data: {
          "scheduleId": schedule.id,
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<List<Schedule>> fetchSchedules() async {
    try {
      final uri = EventsNetworking.getMySchedules;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['schedules'] as List;
      final schedules =
          data.map((element) => Schedule.fromJson(element)).toList();
      return schedules;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<List<EventInterface>> fetchEventInterfaces() async {
    try {
      final uri = EventsNetworking.getEventInterfaces;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['interfaces'] as List;
      final interfaces =
          data.map((element) => EventInterface.fromJson(element)).toList();
      return interfaces;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }
}
