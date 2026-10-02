import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';

class SkeletonizerProductItem extends StatelessWidget {
  const SkeletonizerProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: AppSkeletonEffect.shimmer,
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
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
          children: [
            Image.asset(
              Assets.assets.images.customer.path,
              height: 30,
              width: 30,
            ),

            const SizedBox(width: 12),

            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: AppColor.background,
                borderRadius: BorderRadius.circular(16),

              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  Assets.assets.images.customer.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'بيتزا سوبر سوبريم',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font15Weight700(context),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '125 طلب',
                    style: StyleManager.font13Weight400(context),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColor.background.withOpacity(.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '125',
                        style: StyleManager.font14Weight600(context),
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        Assets.assets.images.amAdelLogo.path,
                        height: 10,
                        width: 10,
                        color: AppColor.mainColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'إجمالي الطلبات',
                    style: StyleManager.font11Weight400(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
