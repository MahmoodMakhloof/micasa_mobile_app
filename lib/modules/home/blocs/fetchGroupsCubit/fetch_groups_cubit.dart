import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:utilities/utilities.dart';

import '../../repositories/home_repository.dart';

part 'fetch_groups_state.dart';

class FetchGroupsCubit extends Cubit<FetchGroupsState> {
 final HomeRepository _homeRepository;
  FetchGroupsCubit(this._homeRepository) : super(FetchGroupsInitial());

  void fetchMyGroups() async {
    emit(FetchGroupsInProgress());
    try {
      var groups = await _homeRepository.fetchMyGroups();
      emit(FetchGroupsSucceeded(groups: groups));
    } catch (e) {
      emit(FetchGroupsFailed(e));
    }
  }

  
}
