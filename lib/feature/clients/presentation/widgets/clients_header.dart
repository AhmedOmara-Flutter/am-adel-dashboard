import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../view_model/clients_cubit.dart';
import 'custom_text_field.dart';
import 'customer_statistics_section.dart';

class ClientsHeader extends StatelessWidget {
  const ClientsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColor.background,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const CustomerStatisticsSection(),
          const SizedBox(height: 10),
          CustomTextField(
            onChanged: (value) {
              context.read<ClientsCubit>().searchClients(value);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}