import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import 'package:utilities/utilities.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit(this._homeRepository) : super(CreateGroupInitial());

  final HomeRepository _homeRepository;

  void createNewGroup(
      {required String name, required List<String> interfaces}) async {
    emit(CreateGroupInProgress());
    try {
      final group = await _homeRepository.createNewGroup(
          name: name, interfaces: interfaces);
      emit(CreateGroupSucceeded(group: group));
    } catch (e) {
      emit(CreateGroupFailed(e));
    }
  }
}
