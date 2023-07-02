import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:utilities/utilities.dart';

import '../../repositories/home_repository.dart';

part 'fetch_group_pics_state.dart';

class FetchGroupPicsCubit extends Cubit<FetchGroupPicsState> {
   final HomeRepository _homeRepository;
  FetchGroupPicsCubit(this._homeRepository) : super(FetchGroupPicsInitial());


  void fetchMyGroupPics() async {
    emit(FetchGroupPicsInProgress());
    try {
      var pics = await _homeRepository.fetchMyGroupPics();
      emit(FetchGroupPicsSucceeded(pics: pics));
    } catch (e) {
      emit(FetchGroupPicsFailed(e));
    }
  }
}
