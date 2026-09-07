import 'package:flutter/material.dart';
import 'app_color.dart';

class StyleManager {
  static const String _fontFamily = 'Cairo';

  /// Secondary Text
  static TextStyle font11Weight400(BuildContext context) => TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 11),
    fontWeight: FontWeight.w400,
  );

  static TextStyle font12Weight500(BuildContext context) => TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 12),
    fontWeight: FontWeight.w500,
  );

  static TextStyle font13Weight400(BuildContext context) => TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 13),
    fontWeight: FontWeight.w400,
  );

  static TextStyle font13Weight600(BuildContext context) => TextStyle(
    color: const Color(0xFFD0D0D0),
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 13),
    fontWeight: FontWeight.w600,
  );

  static TextStyle font13Weight700(BuildContext context) => TextStyle(
    color: AppColor.mainColor,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 13),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font14Weight600(BuildContext context) => TextStyle(
    color: AppColor.mainColor,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.w600,
  );

  static TextStyle font15Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 15),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font15Weight800(BuildContext context) => TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 15),
    fontWeight: FontWeight.w800,
  );

  static TextStyle font16Weight600(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.w600,
  );

  static TextStyle font16Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font18Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 18),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font19Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 19),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font23Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 23),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font28Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 28),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font32Weight700(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 32),
    fontWeight: FontWeight.w700,
  );

  static TextStyle font48Weight900(BuildContext context) => TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: responsiveFontSize(context, fontSize: 48),
    fontWeight: FontWeight.w900,
  );
}

double responsiveFontSize(
    BuildContext context, {
      required double fontSize,
    }) {
  final scaleFactor = getScaleFactor(context);
  final responsiveSize = fontSize * scaleFactor;

  return responsiveSize.clamp(
    fontSize * 0.90,
    fontSize * 1.2,
  );
}

double getScaleFactor(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;

  if (width < 800) {
    return width / 600;
  } else if (width < 1200) {
    return width / 1000;
  } else {
    return width / 1300;
  }
}