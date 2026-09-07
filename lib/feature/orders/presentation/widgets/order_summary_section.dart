import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
    required this.time,
    required this.totalPrice,
    required this.deliveryCost,
  });

  final String time;
  final double totalPrice;
  final double deliveryCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time_rounded,
              size: 16,
              color: AppColor.mainColor,
            ),
          ),

          SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'وقت الطلب',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                time,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),

          const Spacer(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'الإجمالي',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),

              SizedBox(height: 4),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                width: 60,
                height: 1,
                color: AppColor.border,
              ),

              Text(
                '${(totalPrice + deliveryCost).toStringAsFixed(2)} ج.م',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColor.mainColor,
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