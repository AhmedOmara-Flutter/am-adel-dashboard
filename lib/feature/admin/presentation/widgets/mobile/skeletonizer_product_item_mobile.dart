import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../generated/assets.dart';

class SkeletonizerProductItemMobile extends StatelessWidget {
  const SkeletonizerProductItemMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: AppSkeletonEffect.shimmer,
      child: RepaintBoundary(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 7,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Image.asset(
                  Assets.assets.images.img.path,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 9),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  Assets.assets.images.img.path,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'productName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font13Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 13,
                          color: AppColor.textSecondary.withOpacity(.55),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'orderCount مبيعات',
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        minHeight: 4,
                        value: _getProgress(),
                        backgroundColor:
                        AppColor.backgroundDark.withOpacity(.45),
                        valueColor: AlwaysStoppedAnimation(
                          AppColor.orange.withOpacity(.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'orderCount',
                    style: StyleManager.font18Weight700(
                      context,
                    ).copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'طلب',
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  double _getProgress() {
    final count = int.tryParse('55') ?? 0;

    if (count <= 0) {
      return 0.05;
    }

    return (count / (count + 100)).clamp(0.08, 0.95);
  }

}
