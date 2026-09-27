import 'package:am_adel_dashboard/feature/admin/presentation/widgets/admin_top_bar.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/recent_order_card.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/statistics_section.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/config_size.dart';
import 'best_seller_card.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: CustomScrollView(
        slivers: [
          MediaQuery.sizeOf(context).width > ConfigSize.phone
              ? SliverToBoxAdapter(child: AdminTopBar())
              : SliverToBoxAdapter(child: SizedBox.shrink()),
          SliverToBoxAdapter(child: StatisticsSection()),
          SliverToBoxAdapter(
            child: MediaQuery.sizeOf(context).width > ConfigSize.phone
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: RecentOrdersCard()),
                      SizedBox(width: 5),
                      Expanded(child: BestSellerCard()),
                    ],
                  )
                : Column(children: [RecentOrdersCard(), BestSellerCard()]),
          ),
        ],
      ),
    );
  }
}
