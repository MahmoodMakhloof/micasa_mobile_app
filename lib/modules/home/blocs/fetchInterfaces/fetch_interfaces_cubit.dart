import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import 'package:utilities/utilities.dart';

import '../../../../core/rtc/events.dart';
import '../../../../core/rtc/socket_io._helper.dart';

part 'fetch_interfaces_state.dart';

enum InterfacesScope { allBoards, singleBoard, inGroup, toGroup }

extension InterfaceScopeExtension on InterfacesScope {
  String toStr() {
    switch (this) {
      case InterfacesScope.allBoards:
        return "ALL_BOARDS";
      case InterfacesScope.singleBoard:
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
  FetchInterfacesCubit(this._homeRepository) : super(FetchInterfacesInitial()) {
    SocketIOHelper.socket.on(Events.interfaceValueChanged.name, (res) {
      final data =
          InterfaceValueChangeData.fromMap(res as Map<String, dynamic>);

      _changeValueInAllLists(data);

      emit(FetchInterfacesInProgress());
      emit(FetchInterfacesSucceeded(
          allBoardsInterfaces: _allBoardsInterfaces,
          singleBoardInterfaces: _singleBoardInterfaces,
          inGroupInterfaces: _inGroupInterfaces,
          toGroupInterfaces: _toGroupInterfaces));
    });
  }

  void _changeValueInInterfacesList(
      List<Interface> interfaces, InterfaceValueChangeData data) {
    if (interfaces.isNotEmpty) {
      interfaces.firstWhere((i) => i.id == data.interfaceId).value =
          data.value;
    }
  }

  void _changeValueInAllLists(data) {
    _changeValueInInterfacesList(_allBoardsInterfaces, data);
    _changeValueInInterfacesList(_singleBoardInterfaces, data);
    _changeValueInInterfacesList(_inGroupInterfaces, data);
    _changeValueInInterfacesList(_toGroupInterfaces, data);
  }

  void updateInterfaceValue(InterfaceValueChangeData data) async {
    _changeValueInAllLists(data);
    //* socket emitting new value
    await SocketIOHelper.sendMessage(
        Events.interfaceValueChanged.name, data.toMap());
    emit(FetchInterfacesInProgress());
    emit(FetchInterfacesSucceeded(
        allBoardsInterfaces: _allBoardsInterfaces,
        singleBoardInterfaces: _singleBoardInterfaces,
        inGroupInterfaces: _inGroupInterfaces,
        toGroupInterfaces: _toGroupInterfaces));
  }

  List<Interface> _allBoardsInterfaces = [];
  List<Interface> _singleBoardInterfaces = [];
  List<Interface> _inGroupInterfaces = [];
  List<Interface> _toGroupInterfaces = [];

  void fetchInterfaces(
      {required InterfacesScope scope,
      String? text,
      String? groupId,
      String? boardId}) async {
    emit(FetchInterfacesInProgress());
    try {
      switch (scope) {
        case InterfacesScope.allBoards:
          _allBoardsInterfaces = await _homeRepository.fetchMyInterfaces(
              scope: scope, text: text, boardId: boardId, groupId: groupId);
          break;
        case InterfacesScope.singleBoard:
          _singleBoardInterfaces = await _homeRepository.fetchMyInterfaces(
              scope: scope, text: text, boardId: boardId, groupId: groupId);
          break;
        case InterfacesScope.inGroup:
          _inGroupInterfaces = await _homeRepository.fetchMyInterfaces(
              scope: scope, text: text, boardId: boardId, groupId: groupId);
          break;
        case InterfacesScope.toGroup:
          _toGroupInterfaces = await _homeRepository.fetchMyInterfaces(
              scope: scope, text: text, boardId: boardId, groupId: groupId);
          break;
      }

      emit(FetchInterfacesSucceeded(
          allBoardsInterfaces: _allBoardsInterfaces,
          singleBoardInterfaces: _singleBoardInterfaces,
          inGroupInterfaces: _inGroupInterfaces,
          toGroupInterfaces: _toGroupInterfaces));
    } catch (e) {
      emit(FetchInterfacesFailed(e));
    }
  }
}
