import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:utilities/utilities.dart';

extension ChangeLangs on BuildContext {
  ///Change the current language of the app.
  ///
  ///Changes [EasyLocalization], [Get] and [MediaController] language.
  ///
  Future<void> changeLang(Locale locale) async {
    await setLocale(locale);
  }

  Future<void> toogleLang() async {
    final locale = NavigationService.context!.locale;
    Locale englishLocale = const Locale('en', 'US');
    Locale arabicLocale = const Locale('ar', 'EG');
    if (locale.isArabic) {
      await setLocale(englishLocale);
    } else {
      await setLocale(arabicLocale);
    }
  }

  String currentLocale() {
    final locale = NavigationService.context!.locale;
    if (locale.isArabic) {
      return 'العربية';
    } else {
      return 'English';
    }
  }

  String otherLocale() {
    final locale = NavigationService.context!.locale;
    if (locale.isEnglish) {
      return 'التغيير الي اللغة العربية';
    } else {
      return 'Change to english';
    }
  }
}
