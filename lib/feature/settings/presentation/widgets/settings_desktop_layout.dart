import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/build_copy_right.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/print_settings_tile.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/restaurant_status_card.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/setting_danger_card.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../generated/assets.dart';
import 'manager_info_card.dart';

class SettingsDesktopLayout extends StatelessWidget {
  const SettingsDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColor.secondaryColor.withOpacity(
                  AppConstants.borderColor,
                ),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: AppColor.divider,
              ),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            Assets.assets.images.amAdelLogo.path,
            height: 220,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 50),
        const ManagerInfoCard(
          name: 'عم عادل',
          phone: '01098431538',
        ),
        const SizedBox(height: 15),
        const RestaurantStatusCard(),
        const SizedBox(height: 30),
        const PrintSettingsTile(),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: buildOrdersDangerCard(context),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: buildCartDangerCard(context),
            ),
            // const SizedBox(width: 20),
            // Expanded(
            //   child: buildBundleOffersDangerCard(context),
            // ),
            const SizedBox(width: 20),
            Expanded(
              child: buildOffersDangerCard(context),
            ),
          ],
        ),
        const SizedBox(height: 50),
        const BuildCopyRight(),
      ],
    );
  }
}
