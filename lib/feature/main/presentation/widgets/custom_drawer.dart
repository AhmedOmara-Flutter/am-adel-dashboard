import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import 'custom_drawer_header.dart';
import 'drawer_item_list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 10
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(AppConstants.borderColor),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: AppColor.border),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: const [
          CustomDrawerHeader(),
          SizedBox(height: 15),
          Expanded(
            child: DrawerItemListView(),
          ),
        ],
      ),
    );
  }
}