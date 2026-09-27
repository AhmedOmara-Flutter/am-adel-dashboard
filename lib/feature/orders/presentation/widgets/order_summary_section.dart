import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

import '../../../../core/utils/app_color.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
    required this.time,
    required this.subTotal,
    required this.deliveryCost,
    this.couponDiscount = 0,
  });

  final String time;
  final double subTotal;
  final double deliveryCost;
  final double couponDiscount;

  @override
  Widget build(BuildContext context) {
    final totalPrice = subTotal - couponDiscount + deliveryCost;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'ملخص الطلب',
                style: StyleManager.font12Weight500(context).copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.access_time_rounded,
                size: 13,
                color: AppColor.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                time,
                style: StyleManager.font12Weight500(context).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MiniRow(
                      title: 'المنتجات',
                      value: '${subTotal.toStringAsFixed(2)} ج.م',
                    ),
                    const SizedBox(height: 6),
                    _MiniRow(
                      title: 'التوصيل',
                      value: '${deliveryCost.toStringAsFixed(2)} ج.م',
                    ),
                    if (couponDiscount > 0) ...[
                      const SizedBox(height: 6),
                      _MiniRow(
                        title: 'الخصم',
                        value: '-${couponDiscount.toStringAsFixed(2)} ج.م',
                        valueColor: AppColor.green,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 14),

              Container(
                width: 1,
                height: 58,
                color: AppColor.border,
              ),

              const SizedBox(width: 14),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'الإجمالي',
                    style: StyleManager.font12Weight500(context).copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${totalPrice.toStringAsFixed(2)}',
                    style: StyleManager.font23Weight700(context).copyWith(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'ج.م',
                    style:StyleManager.font12Weight500(context).copyWith(
                      color: AppColor.textSecondary,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniRow extends StatelessWidget {
  const _MiniRow({
    required this.title,
    required this.value,
    this.valueColor,
  });

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: StyleManager.font12Weight500(context).copyWith(
            color: AppColor.textSecondary,
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: StyleManager.font12Weight500(context).copyWith(
            color: valueColor ?? AppColor.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}