import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utilities/utilities.dart';

Future<CustomOptions> getCustomOptions() async {
  String? token;
  await FirebaseAuth.instance.currentUser!
      .getIdTokenResult()
      .then((result) => {token = result.token});
  final lang = NavigationService.context!.locale.languageCode.toLowerCase();

  return CustomOptions(token: token, language: lang);
}




