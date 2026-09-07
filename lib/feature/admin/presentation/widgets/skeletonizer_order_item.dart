import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_constants.dart';

class SkeletonizerOrderItem extends StatelessWidget {
  const SkeletonizerOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFF2A2A2A),
        highlightColor: Color(0xFF3A3A3A),
        duration: Duration(milliseconds: 1200),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10
        ),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: AppColor.border,
          ),
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

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ahmed Mohamed',
                    style: StyleManager.font13Weight600(context).copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'كريب سوبر + بيتزا رانش + ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                  SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColor.textSecondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'منذ 5 دقائق',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.orange,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  '250.00 ج.م',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColor.mainColor,
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