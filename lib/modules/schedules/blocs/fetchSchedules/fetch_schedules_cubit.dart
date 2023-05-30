import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/schedules/models/schedule.dart';
import 'package:utilities/utilities.dart';

import '../../../scences/repositories/schedule_repository.dart';

part 'fetch_schedules_state.dart';

class FetchSchedulesCubit extends Cubit<FetchSchedulesState> {
  final ScheduleRepository _scheduleRepository;
  FetchSchedulesCubit(this._scheduleRepository) : super(FetchSchedulesInitial());

  void fetchMySchedules() async {
    emit(FetchSchedulesInProgress());
    try {
      var schedules = await _scheduleRepository.fetchSchedules();
      emit(FetchSchedulesSucceeded(schedules: schedules));
    } catch (e) {
      emit(FetchSchedulesFailed(e));
    }
  }
}
