import 'package:am_adel_dashboard/feature/admin/presentation/widgets/admin_statistics_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/admin_statistics_mobile.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/admin_top_bar.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/recent_order_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/responsive_extension.dart';
import 'best_seller_card.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const AdminViewDesktop()
        : const AdminViewMobile();
  }
}

class AdminViewDesktop extends StatelessWidget {
  const AdminViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: AdminTopBar()),

          const SliverToBoxAdapter(child: AdminStatisticsDesktop()),

          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(flex: 2, child: RecentOrdersCard()),
                SizedBox(width: 5),
                Expanded(child: BestSellerCard()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminViewMobile extends StatelessWidget {
  const AdminViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 10,),),
        const SliverToBoxAdapter(child: AdminStatisticsMobile()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: const [
              RecentOrdersCard(),
              SizedBox(height: 10,),
              BestSellerCard(),
              SizedBox(height: 20,),
            ]),
          ),
        ),
      ],
    );
  }
}
