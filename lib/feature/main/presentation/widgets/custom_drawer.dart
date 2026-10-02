import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';
import 'drawer_item_list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const CustomDrawerDesktop()
        : const CustomDrawerMobile();
  }
}

class CustomDrawerDesktop extends StatelessWidget {
  const CustomDrawerDesktop({super.key});

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
        children: [
          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.cardLight,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.asset(
                      Assets.assets.images.amAdelPerson.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Image.asset(
                    Assets.assets.images.amAdel.path,
                    color: AppColor.mainColor,
                    height: 95,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: DrawerItemListView(),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerMobile extends StatelessWidget {
  const CustomDrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(
              AppConstants.borderColor,
            ),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColor.border,
          ),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              border: Border(
                bottom: BorderSide(
                  color: AppColor.divider.withOpacity(.65),
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.backgroundDark,
                  backgroundImage: AssetImage(
                    Assets.assets.images.amAdelLogo.path,
                  ),
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
                          fontSize: responsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'مهندس احمد عماره',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
          Expanded(
            child: DrawerItemListView(),
          ),
        ],
      ),
    );
  }
}