import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/display_order/presentation/widgets/display_orders_view_body.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class DisplayOrdersView extends StatelessWidget {
  final List<OrderEntity> orders;
  const DisplayOrdersView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'عرض الطلبات',
        buttonType: AppBarButtonType.back,
      ),
      backgroundColor: AppColor.background,
      body: DisplayOrdersViewBody(orders: orders,),
    );
  }
}
