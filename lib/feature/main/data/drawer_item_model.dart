import 'package:flutter/material.dart';

class DrawerItemModel {
  final String title;
  final IconData inactiveIcon;
  final IconData activeIcon;

  const DrawerItemModel({required this.title, required this.inactiveIcon, required this.activeIcon});
}