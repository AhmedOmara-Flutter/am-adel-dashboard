import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/config_size.dart';
import '../../../../generated/assets.dart';
import '../../../orders/presentation/widgets/order_status_badge.dart';

class OrderItem extends StatelessWidget {
  final double amount;
  final String status;
  final Color statusColor;
  final String customerName;
  final String time;
  final String products;
  final double deliveryCost;

  const OrderItem({
    super.key,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.customerName,
    required this.time,
    required this.products,
    required this.deliveryCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery
            .sizeOf(context)
            .width > ConfigSize.phone
            ? 6
            : 0,
        horizontal: 10,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.divider.withOpacity(.55),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.06),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              Assets.assets.images.customer.path,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: StyleManager.font13Weight600(context).copyWith(
                    color: AppColor.mainColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  products,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColor.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OrderStatusBadge(
                color: statusColor,
                title: status,
              ),
              const SizedBox(height: 12),
              Text(
                '${(amount + deliveryCost).toStringAsFixed(2)} ج.م',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
