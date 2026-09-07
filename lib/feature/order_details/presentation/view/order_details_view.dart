import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_details_view_body.dart';
import '../../../../core/entities/order_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_back_button.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailsView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderDetailsViewBody(
        order: order,
      ),
    );
  }
}
