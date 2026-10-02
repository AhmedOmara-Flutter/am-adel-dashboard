import 'package:am_adel_dashboard/core/cubit/orders_cubit/orders_cubit.dart';
import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/core/models/statistics_card_model.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/widgets/clients_statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/clients_cubit.dart';

class CustomerStatisticsSection extends StatelessWidget {
  const CustomerStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const CustomerStatisticsDesktop()
        : const CustomerStatisticsMobile();
  }
}

class CustomerStatisticsDesktop extends StatelessWidget {
  const CustomerStatisticsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientsCubit>().clients;

    final totalPriceWithDelivery = context
        .watch<OrdersCubit>()
        .totalPriceWithDelivery;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: ClientsStatisticsCard(
              model: StatisticsCardModel(
                color: AppColor.mainColor,
                icon: Icons.people_outline_rounded,
                title: 'إجمالي العملاء',
                subTitleNumber: '${clients.length}',
                subTitleText: 'جميع العملاء',
                height: 150,
                iconColor: AppColor.mainColor,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ClientsStatisticsCard(
              model: StatisticsCardModel(
                color: AppColor.accentColor,
                icon: Icons.payments_outlined,
                title: 'إجمالي المبيعات',
                subTitleNumber: '${totalPriceWithDelivery.toStringAsFixed(2)}',
                subTitleText: 'إجمالي قيمة المبيعات',
                height: 150,
                iconColor: AppColor.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerStatisticsMobile extends StatelessWidget {
  const CustomerStatisticsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientsCubit>().clients;

    final totalPriceWithDelivery = context
        .watch<OrdersCubit>()
        .totalPriceWithDelivery;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: ClientsStatisticsCard(
              model: StatisticsCardModel(
                color: AppColor.mainColor,
                icon: Icons.people_outline_rounded,
                title: 'إجمالي العملاء',
                subTitleNumber: '${clients.length}',
                subTitleText: 'جميع العملاء',
                height: 125,
                iconColor: AppColor.mainColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClientsStatisticsCard(
              model: StatisticsCardModel(
                color: AppColor.accentColor,
                icon: Icons.payments_outlined,
                title: 'إجمالي المبيعات',
                subTitleNumber: '${totalPriceWithDelivery.toStringAsFixed(2)}',
                subTitleText: 'إجمالي قيمة المبيعات',
                height: 125,
                iconColor: AppColor.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
