
import 'package:flutter/material.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';
import 'color_manager.dart';
import 'fonts_manager.dart';

ThemeData myTheme(){
  return ThemeData(
    // main color
    primaryColor: ColorManager.primary,
    // card theme
    cardTheme: CardTheme(
      color: ColorManager.grey2,
    ),

    // appBar Theme
    appBarTheme: AppBarTheme(
      color: ColorManager.white,
      elevation: AppSize.s0,

    ),
    //input decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      labelStyle: getRegularStyle(color: ColorManager.primary,fontSize: FontSize.s12),
      fillColor: ColorManager.grey,
      filled: true,
    )
  );
}