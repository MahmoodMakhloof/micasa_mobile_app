import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:utilities/utilities.dart';

import '../../repositories/events_repository.dart';

part 'update_scence_state.dart';

class UpdateScenceCubit extends Cubit<UpdateScenceState> {
  final EventsRepository _scenceRepository;
  UpdateScenceCubit(this._scenceRepository)
      : super(UpdateScenceInitial());

  void updateScence({required Scence newScence}) async {
    emit(UpdateScenceInProgress());
    try {
      final scence =
          await _scenceRepository.updateScence(newScence: newScence);
      emit(UpdateScenceSucceeded(scence: scence));
    } catch (e) {
      emit(UpdateScenceFailed(e));
    }
  }
}
