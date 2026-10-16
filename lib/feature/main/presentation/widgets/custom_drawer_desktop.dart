import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';
import 'drawer_item_list_view.dart';

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
