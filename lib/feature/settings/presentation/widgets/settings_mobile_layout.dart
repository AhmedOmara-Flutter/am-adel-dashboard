import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/build_copy_right.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/print_settings_tile.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/restaurant_status_card.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/setting_danger_card.dart';
import 'manager_info_card_desktop.dart';
import 'manager_info_card_mobile.dart';

class SettingsMobileLayout extends StatelessWidget {
  const SettingsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ManagerInfoCardMobile(),
        const SizedBox(height: 10),
        const RestaurantStatusCard(),
        const SizedBox(height: 10),
        const PrintSettingsTile(),
        const SizedBox(height: 10),
        Column(
          children: [
            buildOrdersDangerCard(context),
            const SizedBox(height: 10),
            buildCartDangerCard(context),
            const SizedBox(height: 10),
            // buildBundleOffersDangerCard(context),
            // const SizedBox(height: 10),
            buildOffersDangerCard(context),
          ],
        ),
        const SizedBox(height: 30),
        const BuildCopyRight(),
        const SizedBox(height: 20),
      ],
    );
  }
}
