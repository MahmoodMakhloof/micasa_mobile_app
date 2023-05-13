import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:utilities/utilities.dart';

ThemeData renderAppLightTheme() {
  final dialogTheme = ThemeData.light().dialogTheme;
  final textTheme = GoogleFonts.cairoTextTheme();

  return ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColorLight: CColors.primary,
    primaryColorDark: CColors.primary,
    disabledColor: Colors.grey,
    unselectedWidgetColor: Colors.grey,
    textTheme: textTheme,
    scaffoldBackgroundColor: CColors.background,
    colorScheme: ColorScheme.light(
      secondary: CColors.darkBlue,
      primary: CColors.primary,
    ),
    cardTheme: const CardTheme(
        color: Colors.white, shadowColor: Colors.black12, elevation: 5),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          centerTitle: true,
          color: Colors.white,
          
          elevation: 0,
          toolbarHeight: 80,
          titleTextStyle: textTheme.bodyLarge!.copyWith(
            color: Colors.black87,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(color: Colors.black87, size: 30),
        ),
    primaryColor: CColors.primary,
    progressIndicatorTheme: ThemeData.light().progressIndicatorTheme.copyWith(
          color: CColors.primary,
        ),
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
        contentPadding: const EdgeInsets.all(15),
        hintStyle: textTheme.bodySmall!.copyWith(color: Colors.grey)),
    dialogTheme: dialogTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: TextStyle(
          color: CColors.primary, fontWeight: FontWeight.bold, fontSize: 18),
      contentTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
    ),
    tabBarTheme:
        ThemeData.light().tabBarTheme.copyWith(labelColor: Colors.black),
    floatingActionButtonTheme:
        ThemeData.light().floatingActionButtonTheme.copyWith(
              backgroundColor: CColors.primary,
              foregroundColor: Colors.white,
            ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: CColors.primary,
            textStyle: textTheme.bodyLarge!.copyWith(color: CColors.primary))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: CColors.primary,
        shape: const RoundedRectangleBorder(borderRadius: KBorders.bc10),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: CColors.primary,
        shape: const RoundedRectangleBorder(borderRadius: KBorders.bc10),
      ),
    ),
    iconTheme: IconThemeData(color: CColors.primary),
  );
}
