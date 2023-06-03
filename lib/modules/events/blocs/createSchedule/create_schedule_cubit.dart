import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utilities/utilities.dart';

import '../../models/scence.dart';
import '../../models/schedule.dart';
import '../../repositories/events_repository.dart';

part 'create_schedule_state.dart';

class CreateScheduleCubit extends Cubit<CreateScheduleState> {
 final EventsRepository _scheduleRepository;
  CreateScheduleCubit(this._scheduleRepository) : super(CreateScheduleInitial());

  void createNewSchedule(
      {required String name,
      required String? description,
      required List<String> days,
      required String time,
      required List<Event> events}) async {
    emit(CreateScheduleInProgress());
    try {
      final schedule = await _scheduleRepository.createNewSchedule(
          name: name, description: description,days: days,time: time, events: events);
      emit(CreateScheduleSucceeded(schedule: schedule));
    } catch (e) {
      emit(CreateScheduleFailed(e));
    }
  }
}
