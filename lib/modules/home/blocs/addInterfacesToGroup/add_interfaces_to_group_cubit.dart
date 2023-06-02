import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import 'package:utilities/utilities.dart';

part 'add_interfaces_to_group_state.dart';

class AddInterfacesToGroupCubit extends Cubit<AddInterfacesToGroupState> {
  AddInterfacesToGroupCubit(this._homeRepository)
      : super(AddInterfacesToGroupInitial());

  final HomeRepository _homeRepository;

  void addInterfacesToGroup(
      {required List<String> interfacesIds,required String groupId}) async {
    emit(AddInterfacesToGroupInProgress());
    try {
      final group =
          await _homeRepository.addInterfacesToGroup(interfacesIds, groupId);
      emit(AddInterfacesToGroupSucceeded(group: group));
    } catch (e) {
      emit(AddInterfacesToGroupFailed(e));
    }
  }
}
