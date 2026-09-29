import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/models/statistics_card_model.dart';
import 'admin_statistics_card.dart';

class SkeletonizerStatisticsSection extends StatelessWidget {
  const SkeletonizerStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AdminStatisticsCard(
                  model: StatisticsCardModel(
                    height: context.isDesktop ? 150 : 125,
                    iconColor: AppColor.transparent,

                    color: Colors.green,
                    icon: Icons.people,
                    title: 'اجمالي العملاء',
                    subTitleNumber:
                    'clients',
                    subTitleText: 'عدد العملاء المسجلين',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AdminStatisticsCard(
                  model: StatisticsCardModel(
                    height: context.isDesktop ? 150 : 125,
                    iconColor: AppColor.transparent,

                    color: Colors.orange,
                    icon: Icons.receipt_long_outlined,
                    title: 'اجمالي الطلبات',
                    subTitleNumber:
                    'clients',
                    subTitleText: 'الطلبات المنفذة',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: AdminStatisticsCard(
                  model: StatisticsCardModel(
                    height: context.isDesktop ? 150 : 125,
                    iconColor: AppColor.transparent,

                    color: Colors.purple,
                    icon: Icons.inventory_2_outlined,
                    title: 'اجمالي المنتجات',
                    subTitleNumber:
                    'clients',

                    subTitleText: 'المنتجات المتاحة',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AdminStatisticsCard(
                  model: StatisticsCardModel(
                    iconColor: AppColor.transparent,
                    height: context.isDesktop ? 150 : 125,
                    color: Colors.blue,
                    icon: Icons.attach_money,
                    title: 'اجمالي المبيعات',
                    subTitleNumber: 'clients',
                    subTitleText: 'إجمالي الإيرادات',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

