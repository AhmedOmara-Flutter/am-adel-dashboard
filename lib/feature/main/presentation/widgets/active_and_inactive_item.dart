import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

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
    final double fontSize = MediaQuery
        .sizeOf(context)
        .width >
        ConfigSize.phone
        ? 13
        : 15;

    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Row(
        children: [
          Icon(
            drawerItemModel.inactiveIcon,
            size: responsiveFontSize(
              context,
              fontSize: 19,
            ),
            color: AppColor.textSecondary.withOpacity(.75),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Text(
              drawerItemModel.title,
              overflow: TextOverflow.ellipsis,
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: responsiveFontSize(
                  context,
                  fontSize: fontSize,
                ),
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
    final double fontSize = MediaQuery
        .sizeOf(context)
        .width >
        ConfigSize.phone
        ? 13
        : 15;

    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColor.mainColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
// Active Indicator
          Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
          ),

          const SizedBox(width: 11),

// Icon
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              drawerItemModel.activeIcon,
              size: responsiveFontSize(
                context,
                fontSize: 17,
              ),
              color: AppColor.mainColor,
            ),
          ),

          const SizedBox(width: 10),

// Title
          Expanded(
            child: Text(
              drawerItemModel.title,
              overflow: TextOverflow.ellipsis,
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                color: AppColor.mainColor,
                fontWeight: FontWeight.w700,
                fontSize: responsiveFontSize(
                  context,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
