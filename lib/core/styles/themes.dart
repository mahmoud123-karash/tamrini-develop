import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/utils/constants.dart';

import '../../styles/styles.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: appColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: appColor,
  ),
  primarySwatch: secondColor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: appColor,
    ),
    backgroundColor: appColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: whiteColor,
    ),
    titleTextStyle: TextStyles.style20Bold.copyWith(
      color: whiteColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: appColor,
    backgroundColor: appColor,
    elevation: 10.0,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.white,
    labelStyle: const TextStyle(
      fontFamily: "cairo",
      color: Colors.white,
    ),
    hintStyle: const TextStyle(
      fontFamily: "cairo",
      color: Colors.white60,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
    ),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.light,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      fontFamily: "cairo",
      color: Colors.black,
      fontSize: 16.0,
    ),
    headlineSmall: bigTitles.headlineSmall,
    bodyMedium: const TextStyle(
      fontFamily: "cairo",
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyLarge: const TextStyle(
      fontFamily: "cairo",
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    ),
    bodySmall: const TextStyle(
      fontFamily: "cairo",
      color: Colors.black54,
    ),
  ),
  fontFamily: 'cairo',
  cardColor: Colors.white,
  secondaryHeaderColor: Colors.white,
  indicatorColor: Colors.black,
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.grey.shade900),
  dialogBackgroundColor: Colors.white,
  disabledColor: Colors.grey.shade300,
);

ThemeData darkTheme = ThemeData(
  primaryColor: appColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: appColor,
  ),
  primarySwatch: secondColor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: appColor,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: appColor,
    elevation: 1.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyles.style20Bold.copyWith(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: kSecondaryColor!,
    elevation: 10.0,
    backgroundColor: kSecondaryColor!,
    unselectedItemColor: Colors.grey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.white,
    labelStyle: const TextStyle(
      fontFamily: "cairo",
      color: Colors.white,
    ),
    hintStyle: const TextStyle(
      fontFamily: "cairo",
      color: Colors.white60,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey[700],
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: const TextStyle(
      fontFamily: "cairo",
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.dark,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
      color: HexColor('333739'),
      shape: const CircularNotchedRectangle(),
      elevation: 3.0),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontFamily: "cairo",
      color: Colors.white,
      fontSize: 16.0,
    ),
    bodySmall: TextStyle(
      fontFamily: "cairo",
      color: Colors.white60,
    ),
    bodyLarge: TextStyle(
      fontFamily: "cairo",
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: "cairo",
      color: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  indicatorColor: Colors.white,
  scaffoldBackgroundColor: HexColor('1f2030'),
  cardColor: HexColor('252a34'),
  secondaryHeaderColor: HexColor('2b3456'),
  canvasColor: HexColor('252a34'),
  disabledColor: HexColor('252a34'),
  dialogBackgroundColor: Colors.black87,
);
