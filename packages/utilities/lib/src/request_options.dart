import 'package:dio/dio.dart';

extension MergeOptions on Options {
  ///Merges the current options with [other].
  ///
  Options merge(Options? other) {
    if (other == null) return this;
    return copyWith(
      method: other.method,
      sendTimeout: other.sendTimeout,
      receiveTimeout: other.receiveTimeout,
      extra: other.extra,
      headers: {
        if (other.headers != null) ...other.headers!,
        if (headers != null) ...headers!,
      },
      responseType: other.responseType,
      contentType: other.contentType,
      validateStatus: other.validateStatus,
      receiveDataWhenStatusError: other.receiveDataWhenStatusError,
      followRedirects: other.followRedirects,
      maxRedirects: other.maxRedirects,
      requestEncoder: other.requestEncoder,
      responseDecoder: other.responseDecoder,
      listFormat: other.listFormat,
    );
  }
}

///Returns the comment [Dio] options used through the app.
///
///with the ability to customize the options add new options
///using [other].
///
Options commonOptions([Options? other]) {
  return Options(
    followRedirects: false,
    validateStatus: (status) => status! >= 200 && status < 300,
    headers: {
      "Accept": 'application/json',
    },
  ).merge(other);
}

///Returns the comment [Dio] options used through the app,
///with a Authorization header.
///
///* [token] is the access token of the current user.
Options commonOptionsWithCustom({
  required CustomOptions customOptions,
}) {
  return commonOptions(
    Options(
      headers: {
        "Authorization": customOptions.token,
        "Accept-Language": customOptions.language
      },
    ),
  );
}

class CustomOptions {
  final String? token;
  final String? language;
  CustomOptions({
     this.token,
     this.language,
  });
}
