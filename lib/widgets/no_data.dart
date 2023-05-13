import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shca/core/helpers/style_config.dart';

import '../generated/locale_keys.g.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.network(
            "https://assets9.lottiefiles.com/packages/lf20_tnrzlN.json",
            width: Style.screenSize.width * .6,
          ),
          Text(
            LocaleKeys.general_no_data.tr(),//TODO: localize it
            style: Style.appTextTheme(context).bodyMedium,
          ),
        ],
      ),
    );
  }
}
