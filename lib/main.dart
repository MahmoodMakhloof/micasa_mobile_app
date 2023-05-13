import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preferences_utilities/preferences_utilities.dart';
import 'package:shca/core/app/app.dart';
import 'package:shca/core/main_utilities/bloc_observer.dart';
import 'package:shca/core/main_utilities/setup_easy_localization.dart';
import 'package:shca/firebase_options.dart';
import 'package:utilities/utilities.dart';

import 'core/main_utilities/repositories.dart';

/*
? Get key SHA1: run `keytool -list -v -keystore debug.jks  -alias debug`
?   keytool -exportcert -alias "key alias" -keystore "path/to/key" | openssl sha1 -binary | openssl base64
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _appInitializations();
  Bloc.observer = AppBlocObserver();
  runApp(
    const RepositoryProviders(
      child: SetUpEasyLocalization(
        child: MyApp(),
      ),
    ),
  );

  
}

Future<void> _appInitializations() async {
  await EasyLocalization.ensureInitialized();
  await PreferencesUtilities.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppPackageInfo.init();
}
