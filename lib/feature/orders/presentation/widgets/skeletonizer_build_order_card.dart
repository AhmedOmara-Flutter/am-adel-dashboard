import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../generated/assets.dart';
import 'order_customer_info.dart';
import 'order_status_action.dart';
import 'order_status_badge.dart';
import 'order_summary_section.dart';

class SkeletonizerBuildOrderCard extends StatelessWidget {
  const SkeletonizerBuildOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: AssetImage(Assets.assets.images.img.path),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OrderCustomerInfo(
                    customerName: 'widget.order.user',
                    orderId: '00',
                    phone: '012012121211',
                    address: ' widget.order.getFullAddress()',
                    products: 'widget.order.cartEntity.cartItems',
                    price: '5555',
                    location: 'widget.order.',
                  ),
                ),

                const SizedBox(width: 8),

                OrderStatusBadge(title: 'widget', color: Colors.transparent),
              ],
            ),

            const SizedBox(height: 12),

            OrderSummarySection(
              time: '{getTimeOnly} ص',
              totalPrice: 1500,
              deliveryCost: 0.0,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('title'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('title'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
