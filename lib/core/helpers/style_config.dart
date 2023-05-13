import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

/// Acts as a color pallette
class CColors {
  CColors._();

  static Color get primary => Colors.indigo;

  static var background = Colors.grey.shade100;

  static const yellow = Color(0xffF8CC1C);
  static const darkOrang = Color(0xffFE8838);

  static const green = Color.fromARGB(255, 24, 170, 77);
  static const grey = Colors.grey;
  static var lightGrey = Colors.grey.shade500;

  static Color black70 = getColorFromHex("#b3000000");

  static const darkBlue = Color(0xff305F72);
  static const lightBlue = Color(0xff5AA6C8);
  static const primary50 = Color.fromRGBO(90, 166, 200, 0.5);

  static Gradient get linearGradient => const LinearGradient(
        colors: [
          darkOrang,
          yellow,
        ],
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.centerEnd,
      );

  static const gr1 = Color(0xff479cf6);
  static const gr2 = Color(0xff9ffd8d);

  static Gradient get blueLinearGradient => const LinearGradient(
        colors: [gr1, gr2],
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.centerEnd,
      );
}

class Style {
  Style._();

  ///Returns the current app context using [Get].
  static ThemeData get appTheme {
    final context = NavigationService.context!;
    return Theme.of(context);
  }

  ///Returns the current app [TextTheme] from [context].
  static TextTheme appTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  ///Returns app [TextTheme] from the current [context].
  static TextTheme textTheme(BuildContext context) {
    return appTheme.textTheme;
  }

  ///Returns [true] if the current device is a mobile phone.
  static bool get isMobileDevice {
    final context = NavigationService.context!;
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    return shortestSide < 600;
  }

  ///Returns [true] if the current device is a tablet.
  static bool get isTablet => !isMobileDevice;

  ///Returns current device screen size.
  ///
  static Size get screenSize {
    final context = NavigationService.context!;
    return MediaQuery.of(context).size;
  }

  static const double defaultDraggableHomeRadius = 0;
}

T adaptive<T>(T mobile, {required T tablet}) {
  if (Style.isMobileDevice) {
    return mobile;
  }
  return tablet;
}
