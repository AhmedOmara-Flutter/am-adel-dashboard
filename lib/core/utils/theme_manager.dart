import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

class ThemeManager {
  static ThemeData darkTheme(BuildContext context)=> ThemeData(
      scaffoldBackgroundColor: AppColor.background,
    ///appBar
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: StyleManager.font19Weight700(context),
      iconTheme: IconThemeData(color: Colors.black),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.mainColor,
      selectionColor: AppColor.mainColor,
      selectionHandleColor: AppColor.mainColor,
    ),
    ///elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: AppColor.mainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          minimumSize: const Size(double.infinity, 65),
        ),
      ),

    ///text theme
    textTheme: TextTheme(
      //title in onboarding
      titleLarge: StyleManager.font23Weight700(context),
      //description in onboarding
      titleMedium: StyleManager.font13Weight600(context),
      // skip button in onboarding
      titleSmall: StyleManager.font13Weight400(context),
      // button label
      labelSmall: StyleManager.font16Weight700(context),
      //googleButton && text under button
      labelMedium: StyleManager.font16Weight600(context),
      //button in featured item
      labelLarge: StyleManager.font13Weight700(context),
      displaySmall: StyleManager.font19Weight700(context),
      bodyLarge: StyleManager.font11Weight400(context),
      bodyMedium: StyleManager.font14Weight600(context)
    ),
  );
}
