import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:shca/core/main_utilities/app_theme.dart';
import 'package:shca/core/main_utilities/setup_system_chrome.dart';
import 'package:shca/views/splash.dart';
import 'package:utilities/utilities.dart';
import '../main_utilities/blocs.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setUpSystemChrome();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviders(
      child: MaterialApp(
        theme: renderAppLightTheme(),
        navigatorKey: NavigationService.navigatorKey,
        title: 'Micasa',
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: [
          ...context.localizationDelegates,
          FormBuilderLocalizations.delegate,
        ],
        locale: context.locale,
        useInheritedMediaQuery: true,
        themeMode: ThemeMode.light,
        home: const SplashView(),
      ),
    );
  }
}
