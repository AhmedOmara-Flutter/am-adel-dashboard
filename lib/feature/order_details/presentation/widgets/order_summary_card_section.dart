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
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الفاتورة',
            style: StyleManager.font13Weight600(
              context,
            ).copyWith(color: AppColor.textPrimary),
          ),

          SizedBox(height: 12),

          _SummaryRow(
            title: 'إجمالي المنتجات',
            value: '${subTotal.toStringAsFixed(2)} ج.م',
          ),

          SizedBox(height: 8),

          if (hasCoupon) ...[
            _SummaryRow(
              title: 'خصم الكوبون',
              value: '-${couponDiscount.toStringAsFixed(2)} ج.م',
              valueColor: AppColor.green,
            ),
            SizedBox(height: 8),
          ],

          _SummaryRow(
            title: 'رسوم التوصيل',
            value: '${deliveryCost.toStringAsFixed(2)} ج.م',
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColor.border,
              height: 1,
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColor.accentColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.divider,
              ),
            ),
            child: Row(
              children: [
                Text(
                  'الإجمالي النهائي',
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),

                const Spacer(),

                Text(
                  '${totalPrice.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font13Weight700(
                    context,
                  ).copyWith(
                    color: AppColor.mainColor,
                  ),
                ),
              ],
            ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.divider),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: StyleManager.font11Weight400(
              context,
            ).copyWith(color: AppColor.textSecondary),
          ),
          const Spacer(),
          Text(
            value,
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(color: valueColor ?? AppColor.textPrimary),
          ),
        ],
      ),
    );
  }
}
