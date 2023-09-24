import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    dividerColor: Colors.transparent,
    fontFamily: FontConstants.fontFamily,
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.darkGrey,
    //TextTheme
    textTheme:  TextTheme(
      headline1: getBoldStyle(color: ColorManager.white, fontSize: 34.sp),
      headline2: getMediumStyle(color: ColorManager.white, fontSize: 22.sp),
      headline3: getRegularStyle(color: ColorManager.white, fontSize: 17.sp),
      headline4: getLightStyle(color: ColorManager.white, fontSize: 15.sp),
      bodyText1: getRegularStyle(color: ColorManager.white, fontSize: 14.sp),
      bodyText2: getRegularStyle(color: ColorManager.white, fontSize: 13.sp),
      subtitle1: getRegularStyle(color: ColorManager.white, fontSize: 11.sp),
      subtitle2:
          getRegularStyle(color: ColorManager.white, fontSize: 16.sp),
      button: getRegularStyle(color: ColorManager.white, fontSize: 17.sp),
      caption: getRegularStyle(color: ColorManager.white, fontSize: 12.sp),
    ),
    //CardTheme
    cardTheme: CardTheme(
        color: ColorManager.darkGrey,
        shadowColor: Colors.grey,
        elevation: AppSize.s4),
    // app bar theme

    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        // ac
        actionsIconTheme: IconThemeData(color: ColorManager.black),
        centerTitle: true,
        color: ColorManager.darkGrey,
        elevation: 0,
        titleTextStyle:
            getBoldStyle(fontSize: FontSize.s16, color: ColorManager.black)),
    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: Colors.grey,
      buttonColor: ColorManager.primary,
    ),
    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getSemiBoldStyle(
                color: ColorManager.darkGrey, fontSize: FontSize.s16),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s28)))),
    // navigationBarTheme
    // navigationBarTheme:NavigationBarThemeData(backgroundColor: ColorManager.red,elevation: 5)
  );
}
