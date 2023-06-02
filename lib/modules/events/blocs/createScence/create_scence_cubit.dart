import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:utilities/utilities.dart';

import '../../models/scence.dart';

part 'create_scence_state.dart';

class CreateScenceCubit extends Cubit<CreateScenceState> {
  final EventsRepository _scenceRepository;
  CreateScenceCubit(this._scenceRepository) : super(CreateScenceInitial());

  void createNewScence(
      {required String name,
      required String? description,
      required List<Event> events}) async {
    emit(CreateScenceInProgress());
    try {
      final scence = await _scenceRepository.createNewScence(
          name: name, description: description, events: events);
      emit(CreateScenceSucceeded(scence: scence));
    } catch (e) {
      emit(CreateScenceFailed(e));
    }
  }
}
