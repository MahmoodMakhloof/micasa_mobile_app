import 'package:dio/dio.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/auth.dart';
import '../../../core/helpers/networking.dart';
import '../utils/networking.dart';

class HomeRepository {
  final Dio _client;

  HomeRepository({Dio? client}) : _client = client ?? Dio();

  Future<List<Group>> fetchMyGroups() async {
    try {
      final uri = HomeNetworking.getMyGroups;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['groups'] as List;
      final groups = data.map((element) => Group.fromJson(element)).toList();
      return groups;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }


  Future<Group> createNewGroup(String name) async {
    try {
      final uri = HomeNetworking.createNewGroup;
      final customOptions = await getCustomOptions();
      final response = await _client.postUri(
        uri,
        data: {"name":name},
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['group'] ;
      final group = Group.fromJson(data);
      return group;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

   Future<Group> addInterfacesToGroup(List<String> interfacesIds,String groupId) async {
    try {
      final uri = HomeNetworking.addInterfacesToGroup;
      final customOptions = await getCustomOptions();
      final response = await _client.patchUri(
        uri,
        data: {"interfacesIds":interfacesIds,"groupId":groupId},
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['group'] ;
      final group = Group.fromJson(data);
      return group;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<List<Interface>> fetchMyInterfaces() async {
    try {
      final uri = HomeNetworking.getMyInterfaces;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['interfaces'] as List;
      final interfaces =
          data.map((element) => Interface.fromJson(element)).toList();
      return interfaces;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<List<Interface>> fetchGroupInterfaces(String groupId) async {
    try {
      final uri = HomeNetworking.getGroupInterfaces(groupId);
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
        
      );
      final data = response.data['interfaces'] as List;
      final interfaces =
          data.map((element) => Interface.fromJson(element)).toList();
      return interfaces;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }
}
