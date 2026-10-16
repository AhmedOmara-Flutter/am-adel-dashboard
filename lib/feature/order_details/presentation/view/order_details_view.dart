import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_details_view_body.dart';
import '../../../../core/entities/order_entity.dart';
import '../../../../core/widgets/custom_app_bar.dart';

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
      appBar: const CustomAppBar(
        title: 'تفاصيل الطلب',
        buttonType: AppBarButtonType.back,
      ),      body: OrderDetailsViewBody(
        order: order,
        orderNumber: orderNumber,
      ),
    );
  }
}