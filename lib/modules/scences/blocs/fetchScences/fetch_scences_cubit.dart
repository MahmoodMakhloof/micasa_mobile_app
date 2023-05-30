import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/scences/repositories/scences_repository.dart';
import 'package:utilities/utilities.dart';

import '../../../Scences/models/scence.dart';


part 'fetch_scences_state.dart';

class FetchScencesCubit extends Cubit<FetchScencesState> {
   final ScenceRepository _scenceRepository;
  FetchScencesCubit(this._scenceRepository) : super(FetchScencesInitial());

  void fetchMyScences() async {
    emit(FetchScencesInProgress());
    try {
      var scences = await _scenceRepository.fetchScences();
      emit(FetchScencesSucceeded(scences: scences as List<Scence>));
    } catch (e) {
      emit(FetchScencesFailed(e));
    }
  }
}