import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class OrderTotalSection extends StatelessWidget {
  final double total;
  final double delivery;

  const OrderTotalSection({
    super.key,
    required this.total,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    final finalTotal = total + delivery;

    return Column(
      children: [
        _PriceRow(
          title: 'المنتجات',
          value: '${total.toStringAsFixed(2)} ج.م',
        ),

        const SizedBox(height: 9),

        _PriceRow(
          title: 'التوصيل',
          value: '${delivery.toStringAsFixed(2)} ج.م',
        ),

        const SizedBox(height: 12),

        Container(
          height: 1,
          color: AppColor.divider.withOpacity(.35),
        ),

        const SizedBox(height: 12),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.09),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 16,
                color: AppColor.mainColor,
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
                ),
              ),
            ),

            const SizedBox(width: 8),

            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${finalTotal.toStringAsFixed(2)} ج.م',
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
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;

  const _PriceRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: StyleManager.font12Weight500(
            context,
          ).copyWith(
            color: AppColor.textSecondary,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: StyleManager.font14Weight600(
            context,
          ).copyWith(
            color: AppColor.textPrimary,
          ),
        ),
      ],
    );
  }
}
