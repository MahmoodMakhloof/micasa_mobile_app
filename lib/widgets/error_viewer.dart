import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shca/generated/locale_keys.g.dart';
import 'package:utilities/utilities.dart';

class ErrorViewer extends StatelessWidget {
  final Object error;
  const ErrorViewer(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget errorWidget;
    if (error is DioError) {
      final err = error as DioError;
      errorWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(err.message),
          Text(err.response?.statusCode?.toString() ?? 'Unknown'),
        ],
      );
    } else {
      errorWidget = Text(
        error.toString(),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.errors_error_happened.tr()),
          const Space.v10(),
          errorWidget,
        ],
      ),
    );
  }
}
