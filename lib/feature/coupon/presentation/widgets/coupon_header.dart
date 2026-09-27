import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

class CouponHeader extends StatelessWidget {
  const CouponHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColor.cardLight.withOpacity(.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColor.divider
            )
          ),

          child: const Icon(
            Icons.local_offer_outlined,
            color: AppColor.accentColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'كوبونات الخصم',
              style: StyleManager.font18Weight700(
                context,
              ).copyWith(color: AppColor.mainColor),
            ),
            const SizedBox(height: 4),
            Text(
              'إدارة كوبونات الخصم الخاصة بالعملاء',
              style: StyleManager.font12Weight500(
                context,
              ).copyWith(color: AppColor.secondaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
