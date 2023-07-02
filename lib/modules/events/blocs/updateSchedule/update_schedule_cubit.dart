import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/models/schedule.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:utilities/utilities.dart';

part 'update_schedule_state.dart';

class UpdateScheduleCubit extends Cubit<UpdateScheduleState> {
  final EventsRepository _scheduleRepository;
  UpdateScheduleCubit(this._scheduleRepository)
      : super(UpdateScheduleInitial());

  void updateSchedule({required Schedule newSchedule}) async {
    emit(UpdateScheduleInProgress());
    try {
      final schedule =
          await _scheduleRepository.updateSchedule(newSchedule: newSchedule);
      emit(UpdateScheduleSucceeded(schedule: schedule));
    } catch (e) {
      emit(UpdateScheduleFailed(e));
    }
  }
}
