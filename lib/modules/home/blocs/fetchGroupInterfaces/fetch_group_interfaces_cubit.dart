import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import 'package:utilities/utilities.dart';

part 'fetch_group_interfaces_state.dart';

class FetchGroupInterfacesCubit extends Cubit<FetchGroupInterfacesState> {
  final HomeRepository _homeRepository;
  FetchGroupInterfacesCubit(this._homeRepository) : super(FetchGroupInterfacesInitial());

  void fetchGroupInterfaces(String groupId) async {
    emit(FetchGroupInterfacesInProgress());
    try {
      var interfaces = await _homeRepository.fetchGroupInterfaces(groupId);
      emit(FetchGroupInterfacesSucceeded(interfaces: interfaces));
    } catch (e) {
      emit(FetchGroupInterfacesFailed(e));
    }
  }
}