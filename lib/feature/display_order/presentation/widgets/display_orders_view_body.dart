import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
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
