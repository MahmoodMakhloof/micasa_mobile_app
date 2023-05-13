import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shca/generated/locale_keys.g.dart';


///Language dialog which the user can choose the current app language
///
///typical use with [showDialog] method
///
///when choosing a new locale the dialog pops and returns the new locale.
///
///ex:
///```
/// showDialog<Locale>(
///   context: context,
///   builder: (_) => ChangeLanguageDialog(
///     currentLocale: Locale('ar'),
///   ),
/// )
/// ```
///
class ChangeLanguageDialog extends StatelessWidget {
  ///App's current locale.
  final Locale currentLocale;

  ///Title of the dialog is displayed in a large font at the top of the dialog.
  final String? title;

  ///Language dialog which the user can choose the current app language
  ///
  const ChangeLanguageDialog({
    Key? key,
    required this.currentLocale,
    @visibleForTesting this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? LocaleKeys.utils_change_lang.tr()), 
      actions: [
        TextButton(
          onPressed: currentLocale == const Locale('ar', 'EG')
              ? null
              : () => Navigator.of(context).pop(const Locale('ar', 'EG')),
          child: const Text("العربية"),
        ),
        TextButton(
          onPressed: currentLocale == const Locale('en', 'US')
              ? null
              : () => Navigator.of(context).pop(const Locale('en', 'US')),
          child: const Text("English"),
        ),
      ],
    );
  }
}
