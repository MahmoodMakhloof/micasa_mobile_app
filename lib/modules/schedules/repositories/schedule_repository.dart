import 'package:dio/dio.dart';
import 'package:shca/modules/schedules/models/schedule.dart';
import 'package:shca/modules/schedules/utils/networking.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/auth.dart';
import '../../../core/helpers/networking.dart';

class ScheduleRepository {
  final Dio _client;

  ScheduleRepository({Dio? client}) : _client = client ?? Dio();

  Future<List<Schedule>> fetchSchedules()async{
    try {
      final uri = SchedulesNetworking.getMySchedules;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['schedules'] as List;
      final schedules = data.map((element) => Schedule.fromJson(element)).toList();
      return schedules;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }
}
