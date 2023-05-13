import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, directives_ordering
import 'package:easy_logger/easy_logger.dart';

import '../../generated/codegen_loader.g.dart';

class SetUpEasyLocalization extends StatefulWidget {
  final Widget child;
  const SetUpEasyLocalization({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<SetUpEasyLocalization> createState() => _SetUpEasyLocalizationState();
}

class _SetUpEasyLocalizationState extends State<SetUpEasyLocalization> {
  @override
  void initState() {
    _initializeLogger();

    super.initState();
  }

  void _initializeLogger() {
    EasyLocalization.logger.enableLevels = <LevelMessages>[
      LevelMessages.error,
      LevelMessages.warning,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      path: 'assets/localization',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      assetLoader: const CodegenLoader(),
      child: widget.child,
    );
  }
}
