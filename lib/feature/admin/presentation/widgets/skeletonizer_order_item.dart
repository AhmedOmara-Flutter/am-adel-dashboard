import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_constants.dart';

class SkeletonizerOrderItem extends StatelessWidget {
  const SkeletonizerOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: AppColor.backgroundDark,
        highlightColor: AppColor.cardLight,
        duration: const Duration(milliseconds: 1200),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(
            AppConstants.borderRadius,
          ),
          border: Border.all(
            color: AppColor.border.withOpacity(0.3),
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

            const SizedBox(width: 12),

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

                  const SizedBox(height: 6),

                  Text(
                    'كريب سوبر + بيتزا رانش + ',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
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
                        'منذ 5 دقائق',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
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
                Container(
                  padding: const EdgeInsets.symmetric(
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
                      color: AppColor.accentColor,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  '250.00 ج.م',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(
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
