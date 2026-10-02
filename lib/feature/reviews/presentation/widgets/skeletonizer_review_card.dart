import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/assets.dart';

class SkeletonizerReviewCard extends StatelessWidget {
  const SkeletonizerReviewCard({super.key});


  @override
  Widget build(BuildContext context) {

    return Skeletonizer(
      enabled: true,
      effect: AppSkeletonEffect.shimmer,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: AppColor.divider.withOpacity(.4)),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withOpacity(.025),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.background,
                    border: Border.all(
                      color: AppColor.accentColor.withOpacity(.45),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: AppColor.backgroundDark,
                    backgroundImage: AssetImage(
                      Assets.assets.images.customer.path,
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'review.name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Weight600(
                          context,
                        ).copyWith(color: AppColor.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: AppColor.textSecondary.withOpacity(.6),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            getDateFormate(''),
                            style: StyleManager.font11Weight400(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: AppColor.accentColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'njkm',
                        style: StyleManager.font16Weight700(
                          context,
                        ).copyWith(color: AppColor.mainColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              decoration: BoxDecoration(
                color: AppColor.background.withOpacity(.55),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        5,
                            (index) => Padding(
                          padding: const EdgeInsetsDirectional.only(end: 3),
                          child: Icon(
                            index < 5
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 15,
                            color: index < 5
                                ? AppColor.accentColor
                                : AppColor.divider,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'تقييم العميل',
                        style: StyleManager.font11Weight400(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Text(
                  'xrdcfvghbjnkml,;.dfcgvhbjnmkl,;.fg vhbn',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font13Weight400(
                      context,
                    ).copyWith(color: AppColor.textPrimary, height: 1.55),
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
