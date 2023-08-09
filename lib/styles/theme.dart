import 'package:flutter/material.dart';
import 'package:usos/styles/colors.dart';

import 'dimensions.dart';

ThemeData createTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: UsosColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: UsosColors.primaryColor,
      elevation: 0,
    ),
    primaryColor: UsosColors.primaryColor,
    brightness: Brightness.light,
    textTheme: _createTextTheme(context),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: UsosColors.white,
          backgroundColor: UsosColors.primaryColor,
          textStyle: const TextStyle(
            fontSize: Dimensions.fontSizeSmallPlus,
          )),
    ));

TextTheme _createTextTheme(BuildContext context) => Theme.of(context).textTheme.copyWith(
      displayLarge: const TextStyle(
        fontSize: Dimensions.fontSizeBig,
        color: UsosColors.white,
      ),
      displayMedium: const TextStyle(
        fontSize: Dimensions.fontSizeMedium,
        color: UsosColors.white,
      ),
      displaySmall: const TextStyle(
        fontSize: Dimensions.fontSizeSmallPlus,
        color: UsosColors.white,
      ),
      titleLarge: const TextStyle(
        fontSize: Dimensions.fontSizeBig,
        color: UsosColors.black,
      ),
      titleMedium: const TextStyle(
        color: UsosColors.black,
      ),
      labelSmall: const TextStyle(
        fontSize: Dimensions.fontSizeSmall,
        fontWeight: FontWeight.w200,
        color: UsosColors.black,
      ),
    );
