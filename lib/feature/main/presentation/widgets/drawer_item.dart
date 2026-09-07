
import 'package:flutter/material.dart';
import 'active_and_inactive_item.dart';

class DrawerItem extends StatelessWidget {
  final DrawerItemModel drawerItemModel;
  final bool isActive;

  const DrawerItem({
    super.key,
    required this.drawerItemModel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveDrawerItem(drawerItemModel: drawerItemModel)
        : InActiveDrawerItem(drawerItemModel: drawerItemModel);
  }
}


class DrawerItemModel {
  final String title;
  final IconData inactiveIcon;
  final IconData activeIcon;

  const DrawerItemModel({required this.title, required this.inactiveIcon, required this.activeIcon});
}