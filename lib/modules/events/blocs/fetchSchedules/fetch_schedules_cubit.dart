import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:utilities/utilities.dart';

import '../../models/schedule.dart';


part 'fetch_schedules_state.dart';

class FetchSchedulesCubit extends Cubit<FetchSchedulesState> {
  final EventsRepository _scheduleRepository;
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
