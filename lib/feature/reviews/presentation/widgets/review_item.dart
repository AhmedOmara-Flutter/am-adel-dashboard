import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final ProductEntity product;

  const ReviewItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteManager.productReviews,
            arguments: product,
          );
        },
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.divider.withOpacity(.55)),
          ),
          child: Row(
            children: [
              // --------------------------------------------------------
              // Product Image
              // --------------------------------------------------------
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
                  child: CachedNetworkImage(
                    imageUrl: product.image ?? '',
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 200),
                    placeholder: (context, url) {
                      return Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColor.accentColor,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.image_outlined,
                        size: 30,
                        color: AppColor.textSecondary,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 13),

              // --------------------------------------------------------
              // Product Information
              // --------------------------------------------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
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
                          product.averageRating.toStringAsFixed(1),
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
                          '${product.reviewsCount} تقييم',
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

              // --------------------------------------------------------
              // Arrow
              // --------------------------------------------------------
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
    );
  }
}
