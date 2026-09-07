import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../clients/presentation/widgets/statistics_card.dart';

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
                child: StatisticsCard(
                  model: StatisticsCardModel(
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
                child: StatisticsCard(
                  model: StatisticsCardModel(
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
                child: StatisticsCard(
                  model: StatisticsCardModel(
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
                child: StatisticsCard(
                  model: StatisticsCardModel(
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
