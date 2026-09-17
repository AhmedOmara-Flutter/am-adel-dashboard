import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/widgets/statistics_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/utils/config_size.dart';
import '../view_model/clients_cubit.dart';

class CustomerStatisticsSection extends StatelessWidget {
  const CustomerStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        if (state is GetClientsLoading) {
          return Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Skeletonizer(
                  child: StatisticsCard(
                    model: StatisticsCardModel(
                      color: AppColor.mainColor,
                      icon: Icons.people,
                      title: '----------------',
                      subTitleNumber: '-----',
                      subTitleText: '--------------------',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Skeletonizer(
                  child: StatisticsCard(
                    model: StatisticsCardModel(
                      color: AppColor.accentColor,
                      icon: Icons.attach_money,
                      title: '----------------',
                      subTitleNumber: '-----',
                      subTitleText: '--------------------',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          );
        }

        final clients = context.read<ClientsCubit>().clients;
        final totalPriceWithDelivery =
            context.read<OrdersCubit>().totalPriceWithDelivery;

        return Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: StatisticsCard(
                model: StatisticsCardModel(
                  color: AppColor.mainColor,
                  icon: Icons.people,
                  title: 'اجمالي العملاء',
                  subTitleNumber: '${clients.length}',
                  subTitleText: 'كل العملاء',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width > ConfigSize.phone
                  ? 10
                  : 15,
            ),
            Expanded(
              child: StatisticsCard(
                model: StatisticsCardModel(
                  color: AppColor.accentColor,
                  icon: Icons.attach_money,
                  title: 'اجمالي المبيعات',
                  subTitleNumber: '${totalPriceWithDelivery} جنيه',
                  subTitleText: 'كل المبيعات',
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}