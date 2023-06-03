import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/models/event_interface.dart';
import 'package:utilities/utilities.dart';

import '../../repositories/events_repository.dart';

part 'fetch_event_intefaces_state.dart';

class FetchEventIntefacesCubit extends Cubit<FetchEventIntefacesState> {
 final EventsRepository _eventInterfaces;
  FetchEventIntefacesCubit(this._eventInterfaces) : super(FetchEventIntefacesInitial());

  void fetchEventInterfaces() async {
    emit(FetchEventIntefacesInProgress());
    try {
      var interfaces = await _eventInterfaces.fetchEventInterfaces();
      emit(FetchEventIntefacesSucceeded(interfaces: interfaces));
    } catch (e) {
      emit(FetchEventIntefacesFailed(e));
    }
  }
}
