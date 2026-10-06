import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/admin_statistics_card_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../../core/models/statistics_card_model.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../clients/presentation/view_model/clients_cubit.dart';
import '../../../../main/presentation/view_model/main_cubit.dart';

class AdminStatisticsDesktop extends StatelessWidget {
  const AdminStatisticsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10,),
        Expanded(
          child: AdminStatisticsCardDesktop(
            model: StatisticsCardModel(
              iconColor: AppColor.mainColor,
              height: 125,
              onTap: () {
                context.read<MainCubit>().changeIndex(6);
              },
              color: Colors.green,
              icon: Icons.people,
              title: 'اجمالي العملاء',
              subTitleNumber:
              '${context
                  .watch<ClientsCubit>()
                  .clients
                  .length}',
              subTitleText: 'عدد العملاء المسجلين',
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: AdminStatisticsCardDesktop(
            model: StatisticsCardModel(
              iconColor: AppColor.mainColor,
              height: 125,
              onTap: () {
                context.read<MainCubit>().changeIndex(5);
              },
              color: Colors.orange,
              icon: Icons.receipt_long_outlined,
              title: 'اجمالي الطلبات',
              subTitleNumber:
              '${context
                  .watch<ClientsCubit>()
                  .orders
                  .length}',
              subTitleText: 'الطلبات المنفذة',
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: AdminStatisticsCardDesktop(
            model: StatisticsCardModel(
              iconColor: AppColor.mainColor,
              height: 125,
              onTap: () {
                context.read<MainCubit>().changeIndex(7);
              },
              color: Colors.purple,
              icon: Icons.inventory_2_outlined,
              title: 'اجمالي العروض',
              subTitleNumber:
              '${context
                  .watch<OffersCubit>()
                  .offers
                  .length}',
              subTitleText: 'العروض المتاحة',
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: AdminStatisticsCardDesktop(
            model: StatisticsCardModel(
              iconColor: AppColor.mainColor,
              height: 125,
              color: Colors.blue,
              icon: Icons.attach_money,
              title: 'اجمالي المبيعات',
              subTitleNumber: context
                  .watch<OrdersCubit>()
                  .totalPriceWithDelivery
                  .toStringAsFixed(2),
              subTitleText: 'إجمالي الإيرادات',
            ),
          ),
        ),
        SizedBox(width: 10,),

      ],
    );
  }
}
