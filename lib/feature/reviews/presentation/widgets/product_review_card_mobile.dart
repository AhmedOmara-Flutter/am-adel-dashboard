import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_container.dart';

class ProductReviewCardMobile extends StatelessWidget {
  const ProductReviewCardMobile({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final rating = product.averageRating;
    final reviews = product.reviewsCount;

    return CustomContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image ?? '',
                  fit: BoxFit.contain,
                  memCacheWidth: 220,
                  memCacheHeight: 220,
                  placeholder: (context, url) {
                    return Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColor.mainColor.withOpacity(.25),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.image_outlined,
                      color: AppColor.textSecondary.withOpacity(.3),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 14,
                          color: AppColor.accentColor,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            product.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font11Weight400(
                              context,
                            ).copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font16Weight700(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            height: 1,
            color: AppColor.divider.withOpacity(.35),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: StyleManager.font32Weight700(
                          context,
                        ).copyWith(color: AppColor.mainColor),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final value = index + 1;

                          return Icon(
                            value <= rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 17,
                            color: AppColor.accentColor,
                          );
                        }),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'متوسط التقييم',
                        style: StyleManager.font11Weight400(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 88,
                  color: AppColor.divider.withOpacity(.35),
                ),
                const SizedBox(width: 18),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.people_alt_outlined,
                            size: 18,
                            color: AppColor.mainColor,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '$reviews شخص',
                            style: StyleManager.font15Weight700(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'قاموا بتقييم هذا المنتج',
                        style: StyleManager.font11Weight400(context),
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                minHeight: 7,
                                value: rating / 5,
                                backgroundColor: AppColor.backgroundDark
                                    .withOpacity(.5),
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColor.accentColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Text(
                            '${((rating / 5) * 100).round()}%',
                            style: StyleManager.font11Weight400(
                              context,
                            ).copyWith(color: AppColor.mainColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'نسبة التقييم العام',
                        style: StyleManager.font11Weight400(context),
                      ),
                    ],
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
