import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/recent_order_card.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/statistics_section.dart';

import '../../../../core/utils/config_size.dart';
import 'best_seller_card.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width > ConfigSize.phone?10:0, bottom: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: StatisticsSection(),
            ),
            SliverToBoxAdapter(
              child:MediaQuery.sizeOf(context).width > ConfigSize.phone? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2,child: RecentOrdersCard()),
                  SizedBox(width: 10),
                  Expanded(child: BestSellerCard()),
                ],
              ):
              Column(
                children: [
                  RecentOrdersCard(),
                  BestSellerCard(),
                ],
              ),
            ),
          ],
        )
    );
  }
}
