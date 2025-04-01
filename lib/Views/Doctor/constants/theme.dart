import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.light(background: AppColors.white),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: darkTextTheme,
  );

  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: _headline1, //34px
    displayMedium: _headline2, //24px
    displaySmall: _headline3, //18px
    headlineMedium: _headline4, //16px
    headlineSmall: _headline5, //14px
    titleLarge: _headline6, //12px

    titleMedium: _subtitle1, //10px
    // subtitle2: _subtitle2, //13px
    bodyLarge: _bodyText1, //16px
    // bodyText2: _bodyText2, //14px //normal
    // button: _button, //14px
    // caption: _caption, //12px
    // overline: _overline, //10px
  );

  static final TextStyle _headline1 = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.normal,
    color: AppColors.black,
    fontSize: 34.sp,
  );

  static final TextStyle _headline2 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );

  static final TextStyle _headline3 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );

  static final TextStyle _headline4 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
  );

  static final TextStyle _headline5 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
  );

  static final TextStyle _headline6 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 12.sp,
  );

  static final TextStyle _subtitle1 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 10.sp,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontFamily: "Roboto",
    color: AppColors.grey,
    fontWeight: FontWeight.normal,
    fontSize: 16.sp,
  );

  // static final TextStyle _bodyText2 = TextStyle(
  //   fontFamily: "RedHatDisplay",
  //   color: AppColors.textColor,
  //   fontWeight: FontWeight.w400,
  //   fontSize: 14.sp,
  // );
}
