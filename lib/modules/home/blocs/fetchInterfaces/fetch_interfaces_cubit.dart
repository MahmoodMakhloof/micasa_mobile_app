import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import 'package:utilities/utilities.dart';

part 'fetch_interfaces_state.dart';

class FetchInterfacesCubit extends Cubit<FetchInterfacesState> {
  final HomeRepository _homeRepository;
  FetchInterfacesCubit(this._homeRepository) : super(FetchInterfacesInitial());

  void fetchInterfaces() async {
    emit(FetchInterfacesInProgress());
    try {
      var interfaces = await _homeRepository.fetchMyInterfaces();
      emit(FetchInterfacesSucceeded(interfaces: interfaces));
    } catch (e) {
      emit(FetchInterfacesFailed(e));
    }
  }
}
