import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/assets.dart';

class SkeletonizerReviewItem extends StatelessWidget {
  const SkeletonizerReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: AppSkeletonEffect.shimmer,
      child:Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          child: CustomContainer(
            child: Row(
              children: [
                Container(
                  width: 82,
                  height: 82,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      Assets.assets.images.img.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'product.name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Weight600(context).copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 17,
                            color: AppColor.accentColor,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            'product',
                            style: StyleManager.font13Weight600(context).copyWith(
                              color: AppColor.textGold,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(width: 9),

                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              color: AppColor.textSecondary.withOpacity(.5),
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 9),

                          Text(
                            '{product.reviewsCount}',
                            style: StyleManager.font11Weight400(
                              context,
                            ).copyWith(color: AppColor.textSecondary),
                          ),
                        ],
                      ),

                      const SizedBox(height: 9),

                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 14,
                            color: AppColor.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'عرض تقييمات المنتج',
                            style: StyleManager.font13Weight600(
                              context,
                            ).copyWith(color: AppColor.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
