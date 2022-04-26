import 'package:flutter/material.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';

final ThemeData appThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: ColorTheme.primary,
    fontFamily: 'Poppins',
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: ColorTheme.inputBackgroundGrey,
      contentPadding: EdgeInsets.all(14.0),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorTheme.inputBorderGrey),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorTheme.inputBorderGrey),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorTheme.primary),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(6))),
    ));
