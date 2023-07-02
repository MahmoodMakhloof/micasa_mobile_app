import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utilities/utilities.dart';

import '../../models/scence.dart';
import '../../repositories/events_repository.dart';

part 'delete_scence_state.dart';

class DeleteScenceCubit extends Cubit<DeleteScenceState> {
  final EventsRepository _scenceRepository;
  DeleteScenceCubit(this._scenceRepository)
      : super(DeleteScenceInitial());

  void deleteScence({required Scence scence}) async {
    emit(DeleteScenceInProgress());
    try {
      await _scenceRepository.deleteScence(scence: scence);
      emit(DeleteScenceSucceeded());
    } catch (e) {
      emit(DeleteScenceFailed(e));
    }
  }
}
