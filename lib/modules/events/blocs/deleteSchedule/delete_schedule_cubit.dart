import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/models/schedule.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:utilities/utilities.dart';

part 'delete_schedule_state.dart';

class DeleteScheduleCubit extends Cubit<DeleteScheduleState> {
  final EventsRepository _scheduleRepository;
  DeleteScheduleCubit(this._scheduleRepository)
      : super(DeleteScheduleInitial());

  void deleteSchedule({required Schedule schedule}) async {
    emit(DeleteScheduleInProgress());
    try {
      await _scheduleRepository.deleteSchedule(schedule: schedule);
      emit(DeleteScheduleSucceeded());
    } catch (e) {
      emit(DeleteScheduleFailed(e));
    }
  }
}
