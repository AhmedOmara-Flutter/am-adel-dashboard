import 'package:am_adel_dashboard/feature/admin/presentation/widgets/mobile/admin_statistics_mobile.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/mobile/recent_order_card_mobile.dart';
import 'package:flutter/material.dart';
import 'best_seller_card_mobile.dart';

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
              RecentOrderCardMobile(),
              SizedBox(height: 10,),
              BestSellerCardMobile(),
              SizedBox(height: 20,),
            ]),
          ),
        ),
      ],
    );
  }
}
