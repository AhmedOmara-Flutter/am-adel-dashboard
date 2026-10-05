import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/best_seller_card_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/admin_statistics_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/admin_top_bar.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/quick_actions_section.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/recent_order_card_desktop.dart';
import 'package:flutter/material.dart';
import '../mobile/best_seller_card_mobile.dart';

class AdminViewDesktop extends StatelessWidget {
  const AdminViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const AdminTopBar(),
        const SizedBox(height: 10),
        const AdminStatisticsDesktop(),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(flex: 2, child: RecentOrderCardDesktop()),
                SizedBox(width: 10),
                Expanded(child: BestSellerCardDesktop()),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: QuickActionsSection(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
