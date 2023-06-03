import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:utilities/utilities.dart';

import '../../../events/models/scence.dart';


part 'fetch_scences_state.dart';

class FetchScencesCubit extends Cubit<FetchScencesState> {
   final EventsRepository _scenceRepository;
  FetchScencesCubit(this._scenceRepository) : super(FetchScencesInitial());

  void fetchMyScences() async {
    emit(FetchScencesInProgress());
    try {
      var scences = await _scenceRepository.fetchScences();
      emit(FetchScencesSucceeded(scences: scences));
    } catch (e) {
      emit(FetchScencesFailed(e));
    }
  }
}