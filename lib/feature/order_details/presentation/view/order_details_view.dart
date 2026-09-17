import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_details_view_body.dart';

import '../../../../core/entities/order_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_back_button.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderEntity order;
  final int orderNumber;

  const OrderDetailsView({
    super.key,
    required this.order,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const CustomBackButton(),
        ),
        centerTitle: true,
        title: Text(
          'تفاصيل الطلب',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(
            color: AppColor.textOnDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: OrderDetailsViewBody(
        order: order,
        orderNumber: orderNumber,
      ),
    );
  }
}