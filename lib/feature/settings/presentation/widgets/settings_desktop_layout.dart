import 'package:am_adel_dashboard/feature/settings/presentation/widgets/build_copy_right.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/print_settings_tile.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/setting_danger_card.dart';
import 'package:flutter/material.dart';

import 'manager_info_card.dart';

class SettingsDesktopLayout extends StatelessWidget {
  const SettingsDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ManagerInfoCard(
          name: 'عم عادل',
          phone: '01098431538',
        ),
        const SizedBox(height: 10),
        const PrintSettingsTile(),
        const SizedBox(height: 10),
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
        SizedBox(height: 50,),
        const BuildCopyRight(),
      ],
    );
  }
}
