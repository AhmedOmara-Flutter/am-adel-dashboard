import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../generated/assets.dart';

class SkeletonizerProductItemDesktop extends StatelessWidget {
  const SkeletonizerProductItemDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: AppSkeletonEffect.shimmer,
      child: RepaintBoundary(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Image.asset(
                  Assets.assets.images.img.path,
                  width: 23,
                  height: 23,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(13),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                Assets.assets.images.img.path,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'productName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.mainColor.withOpacity(.06),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.shopping_bag_outlined,
                                size: 13,
                                color: AppColor.mainColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'orderCount مبيعات',
                                style: StyleManager.font11Weight400(
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
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 1,
                height: 38,
                color: AppColor.divider.withOpacity(.55),
              ),
              const SizedBox(width: 16),
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

}
