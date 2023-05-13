// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "general": {
    "no_data": "No data"
  },
  "auth": {
    "sign_with_google": "SignIn With Google",
    "logout": "Logout"
  },
  "pages": {
    "home": "Home",
    "boards": "Boards",
    "scences": "Scences",
    "schedule": "Schedules"
  },
  "errors": {
    "no_internet": "No Internet Connection",
    "error_happened": "Error Happened",
    "retry": "Retry"
  },
  "utils": {
    "copied_to_clipboard": "Copied to clipboard",
    "change_lang": "Change Language"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US};
}
