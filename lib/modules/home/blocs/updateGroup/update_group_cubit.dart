import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utilities/utilities.dart';

import '../../models/group.dart';
import '../../repositories/home_repository.dart';

part 'update_group_state.dart';

class UpdateGroupCubit extends Cubit<UpdateGroupState> {
  UpdateGroupCubit(this._homeRepository) : super(UpdateGroupInitial());

  final HomeRepository _homeRepository;

  void updateGroup(
      {required String name,
      required String groupId,
      required String image}) async {
    emit(UpdateGroupInProgress());
    try {
      final group = await _homeRepository.updateGroup(
          groupId: groupId, name: name, image: image);
      emit(UpdateGroupSucceeded(group: group));
    } catch (e) {
      emit(UpdateGroupFailed(e));
    }
  }
}
