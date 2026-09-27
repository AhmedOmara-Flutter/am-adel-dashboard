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
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        border: Border.all(
          color: AppColor.border.withOpacity(.45),
          width: 1,
        ),
      ),
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
