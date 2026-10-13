import 'package:am_adel_dashboard/core/cubit/orders_cubit/orders_cubit.dart';
import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/core/models/statistics_card_model.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/widgets/clients_statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/clients_cubit.dart';
import 'customer_statistics_desktop.dart';
import 'customer_statistics_mobile.dart';

class CustomerStatisticsSection extends StatelessWidget {
  const CustomerStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const CustomerStatisticsDesktop()
        : const CustomerStatisticsMobile();
  }
}


