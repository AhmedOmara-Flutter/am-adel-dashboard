import 'package:flutter/material.dart';
class StatisticsCardModel {
  final Color color;
  final IconData icon;
  final Color iconColor;
  final double height;
  final String title;
  final String subTitleNumber;
  final String subTitleText;
  final VoidCallback? onTap;

  StatisticsCardModel({
    required this.color,
    required this.icon,
    required this.title,
    required this.subTitleNumber,
    required this.subTitleText,
    required this.height,
    this.onTap,
    required this.iconColor,
  });
}
