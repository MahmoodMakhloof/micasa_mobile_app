import 'dart:convert';

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:shca/widgets/snack_bars.dart';


Interceptor filterDataObject() {
  return InterceptorsWrapper(
    onResponse: (response, handler) async {
      try {
        final data = response.data['data'];
        response.extra['msg'] = response.data['msg'];

        if (data != null) {
          response.data = data;
        }
        return handler.next(response);
      } catch (e) {
        return handler.reject(
          DioError(
            requestOptions: response.requestOptions,
            error: e,
          ),
        );
      }
    },
    onError: (error, handler) {
      try {
        return handler.reject(error);
      } catch (e) {
        return handler.reject(
          DioError(
            requestOptions: error.requestOptions,
            error: e,
          ),
        );
      }
    },
  );
}

final DataConnectionChecker _connectionChecker = DataConnectionChecker();

connectedToInternet() async {
  final result = await _connectionChecker.hasConnection;
  return result;
}

class InternetConnectionError implements Exception {
  final message = "No Internet Connection"; //TODO: Localize
}

class ServerError implements Exception {
  final String message;

  final bool success;

  const ServerError._({
    required this.message,
    required this.success,
  });

  factory ServerError.fromRaw(String data) {
    final json = jsonDecode(data);
    return ServerError.fromJson(json);
  }

  factory ServerError.fromJson(Map<String, dynamic> json) {
    return ServerError._(
      message: json['msg'] ?? '',
      success: json['SUCCESS'] ?? false,
    );
  }
}

void showErrorsAsToast(Object e) {
  CSnackBar.failure(messageText: stringifyError(e)).showWithoutContext();
}

String stringifyError(Object e) {
  if (e is ServerError) {
    return e.message;
  } else if (e is InternetConnectionError) {
    return e.message;
  } else {
    return e.toString();
  }
}

Exception decodeDioError(DioError error) {
  if (!connectedToInternet()) {
    return InternetConnectionError();
  } else {
    if (error.response == null) return error;
    final data = error.response!.data;
    return ServerError.fromJson(data);
  }
}
