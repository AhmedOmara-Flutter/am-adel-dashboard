import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import 'drawer_item.dart';

class InActiveDrawerItem extends StatelessWidget {
  const InActiveDrawerItem({
    super.key,
    required this.drawerItemModel,
  });

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),

      padding: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Icon(
            drawerItemModel.inactiveIcon,
            color: AppColor.textSecondary,
            size: responsiveFontSize(context, fontSize: 18),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              drawerItemModel.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: responsiveFontSize(context, fontSize: MediaQuery
                    .sizeOf(context)
                    .width > ConfigSize.phone? 13:15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveDrawerItem extends StatelessWidget {
  const ActiveDrawerItem({
    super.key,
    required this.drawerItemModel,
  });

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Icon(
            drawerItemModel.activeIcon,
            color: Colors.white,
            size: responsiveFontSize(context, fontSize: 18),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              drawerItemModel.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontSize: responsiveFontSize(context, fontSize:  MediaQuery
                    .sizeOf(context)
                    .width > ConfigSize.phone?13:15),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
