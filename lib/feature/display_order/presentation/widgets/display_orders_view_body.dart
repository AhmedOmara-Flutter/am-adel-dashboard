import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../core/widgets/custom_back_button.dart';
import 'display_order_card.dart';


class DisplayOrdersViewBody extends StatelessWidget {
  final List<OrderEntity> orders;
  const DisplayOrdersViewBody({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return DisplayOrderCard(
                      order: orders[index],
                      orderNumber: orders.length - index,
                    );
                  },
                ),
            ),
      ],
    );
  }
}
