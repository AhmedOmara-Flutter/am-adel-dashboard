import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
    required this.time,
    required this.totalPrice,
    required this.deliveryCost,
    this.couponDiscount = 0,
  });

  final String time;
  final double totalPrice;
  final double deliveryCost;
  final double couponDiscount;

  @override
  Widget build(BuildContext context) {
    final hasCoupon = couponDiscount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time_rounded,
              size: 15,
              color: AppColor.mainColor,
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'وقت الطلب',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColor.textSecondary,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                time,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColor.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Spacer(),

          if (hasCoupon) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: AppColor.green.withOpacity(0.10),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_offer_rounded,
                    size: 12,
                    color: AppColor.green,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '-${couponDiscount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColor.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'الإجمالي',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColor.textSecondary,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                '${totalPrice.toStringAsFixed(2)} ج.م',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColor.mainColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
