import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/reviews/domain/entities/review_entity.dart';
import '../../../../generated/assets.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(AppConstants.borderColor),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: AppColor.border),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColor.background,
            backgroundImage: AssetImage(
              Assets.assets.images.customer.path,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الاسم + التاريخ
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Weight600(context),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        getDateFormate(review.date),
                        style: StyleManager.font11Weight400(context).copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// التقييم
                Row(
                  children: [
                    ...List.generate(
                      5,
                          (index) => Icon(
                        index < review.rating
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "${review.rating}/5",
                      style: StyleManager.font12Weight500(context),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  review.reviewDescription,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textSecondary,
                    height: 1.5,
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