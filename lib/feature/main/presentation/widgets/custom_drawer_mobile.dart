import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/assets.dart';
import 'drawer_item_list_view.dart';

class CustomDrawerMobile extends StatelessWidget {
  const CustomDrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top:20,left: 12,right: 12,bottom: 10),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              border: Border(
                bottom: BorderSide(color: AppColor.divider.withOpacity(.65)),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.backgroundDark,
                  backgroundImage: AssetImage(Assets.assets.images.me.path),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'صباح الخير 👋',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: responsiveFontSize(context, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'احمد عماره',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: AppColor.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: responsiveFontSize(
                                context,
                                fontSize: 14,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(child: DrawerItemListView()),
        ],
      ),
    );
  }
}
