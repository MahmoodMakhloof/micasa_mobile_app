import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import 'package:utilities/utilities.dart';

part 'fetch_interfaces_state.dart';

enum InterfacesScope { allBoards, singleBoards, inGroup, toGroup }

extension InterfaceScopeExtension on InterfacesScope {
  String toStr() {
    switch (this) {
      case InterfacesScope.allBoards:
        return "ALL_BOARDS";
      case InterfacesScope.singleBoards:
        return "SINGLE_BOARD";
      case InterfacesScope.inGroup:
        return "IN_GROUP";
      case InterfacesScope.toGroup:
        return "TO_GROUP";
    }
  }
}

class FetchInterfacesCubit extends Cubit<FetchInterfacesState> {
  final HomeRepository _homeRepository;
  FetchInterfacesCubit(this._homeRepository) : super(FetchInterfacesInitial());

  void fetchInterfaces(
      {required InterfacesScope scope,
      String? text,
      String? groupId,
      String? boardId}) async {
    emit(FetchInterfacesInProgress());
    try {
      var interfaces = await _homeRepository.fetchMyInterfaces(scope: scope,text: text,boardId: boardId,groupId: groupId);
      emit(FetchInterfacesSucceeded(interfaces: interfaces));
    } catch (e) {
      emit(FetchInterfacesFailed(e));
    }
  }
}
