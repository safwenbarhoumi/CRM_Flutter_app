import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    textTheme: darkTextTheme,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.black,
      onPrimary: AppColors.white,
      secondary: AppColors.grey,
      onSecondary: AppColors.black,
      surface: AppColors.white,
      onSurface: AppColors.black,
      background: AppColors.white,
      error: Colors.red,
      onError: Colors.white,
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: _headline1, // 34px
    displayMedium: _headline2, // 24px
    displaySmall: _headline3, // 18px
    headlineMedium: _headline4, // 16px
    headlineSmall: _headline5, // 14px
    titleLarge: _headline6, // 12px
    titleMedium: _subtitle1, // 10px
    bodyLarge: _bodyText1, // 16px
  );

  static final TextStyle _headline1 = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.normal,
    color: AppColors.black,
    fontSize: 34,
  );

  static final TextStyle _headline2 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static final TextStyle _headline3 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static final TextStyle _headline4 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final TextStyle _headline5 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static final TextStyle _headline6 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  static final TextStyle _subtitle1 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 10,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.grey,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
}
