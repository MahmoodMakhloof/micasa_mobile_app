import 'package:dio/dio.dart';
import 'package:shca/modules/scences/models/Scence.dart';
import 'package:shca/modules/scences/utils/networking.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/auth.dart';
import '../../../core/helpers/networking.dart';

class ScenceRepository {
  final Dio _client;

  ScenceRepository({Dio? client}) : _client = client ?? Dio();

  Future<List<Scence>> fetchScences()async{
    try {
      final uri = ScencesNetworking.getMyScences;
      final customOptions = await getCustomOptions();
      final response = await _client.getUri(
        uri,
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['scences'] as List;
      final scences = data.map((element) => Scence.fromJson(element)).toList();
      return scences;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }
}
