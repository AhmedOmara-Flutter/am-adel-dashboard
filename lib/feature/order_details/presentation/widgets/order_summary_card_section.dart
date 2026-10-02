import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

class OrderSummaryCardSection extends StatelessWidget {
  const OrderSummaryCardSection({
    super.key,
    required this.subTotal,
    required this.deliveryCost,
    this.couponDiscount = 0,
  });

  final double subTotal;
  final double deliveryCost;
  final double couponDiscount;

  @override
  Widget build(BuildContext context) {
    final hasCoupon = couponDiscount > 0;

    final totalPrice =
        subTotal - couponDiscount + deliveryCost;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider.withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 19,
                color: AppColor.mainColor,
              ),
              const SizedBox(width: 9),
              Text(
                'ملخص الفاتورة',
                style: StyleManager.font13Weight600(
                  context,
                ).copyWith(
                  color: AppColor.textPrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SummaryRow(
            title: 'إجمالي المنتجات',
            value: '${subTotal.toStringAsFixed(2)} ج.م',
          ),

          const SizedBox(height: 10),

          if (hasCoupon) ...[
            _SummaryRow(
              title: 'خصم الكوبون',
              value: '-${couponDiscount.toStringAsFixed(2)} ج.م',
              valueColor: AppColor.green,
            ),
            const SizedBox(height: 10),
          ],

          _SummaryRow(
            title: 'رسوم التوصيل',
            value: '${deliveryCost.toStringAsFixed(2)} ج.م',
          ),

          const SizedBox(height: 14),

          Container(
            height: 1,
            color: AppColor.divider.withOpacity(.45),
          ),

          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  'الإجمالي النهائي',
                  style: StyleManager.font13Weight600(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${totalPrice.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font15Weight700(
                    context,
                  ).copyWith(
                    color: AppColor.mainColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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
        Expanded(
          child: Text(
            title,
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(
              color: AppColor.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: StyleManager.font12Weight500(
            context,
          ).copyWith(
            color: valueColor ?? AppColor.textPrimary,
          ),
        ),
      ],
    );
  }
}
