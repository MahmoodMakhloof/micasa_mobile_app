import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:shca/core/helpers/logger.dart';
import 'package:utilities/utilities.dart';

import '../core/helpers/style_config.dart';

///Snackbar display duration time. (2 seconds)
const _snackBarDisplayDuration = Duration(milliseconds: 2000);

var kSnackBarBarBackground = CColors.black70;

class CSnackBar {
  // ignore: unused_element
  CSnackBar._(
    this.duration,
    this.icon,
    this.messageText,
    this.messageStyle,
    this.message,
    this.avoidNavigationBar,
  );

  ///Snackbar display duration, defaults to `2 seconds`.
  final Duration duration;

  ///The displayed leading icon.
  ///
  final Widget? icon;

  ///The main message string.
  final String? messageText;

  ///Message string Text style, defaults to `subtitle1`.
  ///
  final TextStyle? messageStyle;

  ///Individual Message to create more customized widget.
  final Widget? message;

  ///Avoids the bottom persistent navigation bar, defaults to `true`.
  final bool avoidNavigationBar;

  ///Returns a success snackbar with ` CupertinoIcons.check_mark_circled_solid` icon of color `green`.
  ///
  ///See also:
  ///* [show] Displays the current snackbar in [context].
  ///* [showWithoutContext] Displays the current snackbar in an auto retrieved [context] from [Get].
  const CSnackBar.success({
    required this.messageText,
    this.avoidNavigationBar = true,
    this.messageStyle,
  })  : duration = _snackBarDisplayDuration,
        icon = const Icon(
          CupertinoIcons.check_mark,
          color: Colors.green,
        ),
        message = null;

  ///Returns a failure snackbar with ` CupertinoIcons.exclamationmark_circle_fill` icon of color `red`.
  ///
  ///See also:
  ///* [show] Displays the current snackbar in [context].
  ///* [showWithoutContext] Displays the current snackbar in an auto retrieved [context] from [Get].
  const CSnackBar.failure({
    required this.messageText,
    this.avoidNavigationBar = true,
    this.messageStyle,
  })  : duration = _snackBarDisplayDuration,
        icon = const Icon(
          CupertinoIcons.exclamationmark,
          color: Colors.red,
        ),
        message = null;

  ///Creates a custom snackbar with an icon and a message.
  ///
  ///See also:
  ///* [show] Displays the current snackbar in [context].
  ///* [showWithoutContext] Displays the current snackbar in an auto retrieved [context] from [Get].
  const CSnackBar.custom({
    this.duration = _snackBarDisplayDuration,
    this.icon,
    this.messageText,
    this.message,
    this.avoidNavigationBar = true,
    this.messageStyle,
  });

  ///Displays the current snackbar in [context].
  ///
  Future<void> show(BuildContext context) async {
    const border = RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)));

    try {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: kSnackBarBarBackground,
            duration: duration,
            shape: border,
            padding:
                EdgeInsets.fromLTRB(20, 10, 20, avoidNavigationBar ? 17 : 5),
            content: Row(
              children: [
                if (icon != null) ...[
                  IconTheme.merge(
                    data: const IconThemeData(size: 30),
                    child: icon!,
                  ),
                  const Space.h10(),
                ],
                Expanded(
                  child: message ??
                      Text(
                        messageText ?? '-',
                        style: Style.appTextTheme(context)
                            .button
                            ?.copyWith(color: Colors.white)
                            .merge(messageStyle),
                      ),
                ),
              ],
            ),
          ),
        );
    } on Exception catch (e, stacktrace) {
      appLogger.d("Error while displaying snackbar", e, stacktrace);
    }
    return Future<void>.value();
  }

  ///Displays the current snackbar in an auto retrieved [context] from [Get].
  ///
  Future<void> showWithoutContext() async {
    final context = NavigationService.context!;
    return show(context);
  }
}
