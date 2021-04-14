import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  MyAppTheme._();

  static const Color primaryLightColor = const Color(0xff212121);
  static const Color primaryLightColorVariant = const Color(0xff484848);
  static const Color secondaryLightColor = const Color(0xff66bb6a);
  static const Color secondaryLightColorVariant = const Color(0xff80e27e);
  static final Color primaryLightSwatchAppColor =
      MyAppTheme.generateMaterialColor(primaryLightColor);

  static const Color primaryDarkColor = const Color(0xff212121);
  static const Color primaryDarkColorVariant = const Color(0xff484848);
  static const Color secondaryDarkColor = const Color(0xff66bb6a);
  static const Color secondaryDarkColorVariant = const Color(0xff80e27e);
  static final Color primaryDarkSwatchAppColor =
      MyAppTheme.generateMaterialColor(primaryDarkColor);

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: primaryLightColor,
    primaryVariant: primaryLightColorVariant,
    secondary: secondaryLightColor,
    secondaryVariant: secondaryLightColorVariant,
    surface: Colors.white,
    background: Colors.white,
    error: const Color(0xffb00020),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightColorScheme.background,
    primarySwatch: primaryLightSwatchAppColor,
    colorScheme: _lightColorScheme,
    textTheme: _lightTextTheme,
    primaryColor: _lightColorScheme.primary,
    appBarTheme: AppBarTheme(
      color: _lightColorScheme.background,
      iconTheme:
          IconThemeData(color: _lightColorScheme.primaryVariant, size: 20.0),
      textTheme: _lightTextTheme.copyWith(
          headline6: _lightTextTheme.headline6
              .copyWith(color: _lightColorScheme.primaryVariant)),
      elevation: 0.0,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: _lightColorScheme.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: _lightColorScheme.primary.withOpacity(0.5),
    ),
    buttonTheme: ButtonThemeData(
      height: 48.0,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      disabledColor: primaryLightColor.withOpacity(0.38),
      buttonColor: primaryLightColor,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: const Color(0xffbb86fc),
    primaryVariant: const Color(0xff3700B3),
    secondary: const Color(0xff03dac6),
    secondaryVariant: const Color(0xff03dac6),
    surface: const Color(0xff121212),
    background: const Color(0xff121212),
    error: const Color(0xffcf6679),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkColorScheme.background,
    primarySwatch: primaryDarkSwatchAppColor,
    colorScheme: _darkColorScheme,
    textTheme: _darkTextTheme,
    primaryColor: _darkColorScheme.primary,
    appBarTheme: AppBarTheme(
      color: _darkColorScheme.background,
      iconTheme:
          IconThemeData(color: _darkColorScheme.primaryVariant, size: 20.0),
      textTheme: _darkTextTheme.copyWith(
          headline6: _darkTextTheme.headline6
              .copyWith(color: _darkColorScheme.primaryVariant)),
      elevation: 0.0,
    ),
    tabBarTheme: TabBarTheme(),
    buttonTheme: ButtonThemeData(
      height: 48.0,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      disabledColor: primaryDarkColor.withOpacity(0.38),
      buttonColor: primaryDarkColor,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: GoogleFonts.quicksand(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.quicksand(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.quicksand(
      fontSize: 48,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.quicksand(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.openSans(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: GoogleFonts.quicksand(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.quicksand(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.quicksand(
      fontSize: 48,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.quicksand(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.openSans(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );

  /// Material color generators
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
