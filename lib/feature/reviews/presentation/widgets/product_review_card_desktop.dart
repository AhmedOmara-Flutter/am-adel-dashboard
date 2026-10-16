import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_container.dart';

class ProductReviewCardDesktop extends StatelessWidget {
  const ProductReviewCardDesktop({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 320,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColor.background.withOpacity(.55),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: CachedNetworkImage(
                imageUrl: product.image ?? "",
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: StyleManager.font16Weight700(context).copyWith(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              product.category,
              style: StyleManager.font12Weight500(
                context,
              ).copyWith(color: AppColor.mainColor),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  icon: Icons.attach_money,
                  title: "السعر",
                  value: "${product.price} ج",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _InfoCard(
                  icon: Icons.star,
                  title: "التقييم",
                  value: product.averageRating.toStringAsFixed(1),
                  color: AppColor.accentColor,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _InfoCard(
                  icon: Icons.reviews,
                  title: "المراجعات",
                  value: "${product.reviewsCount}",
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الوصف",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.background.withOpacity(.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  product.description,
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(color: AppColor.textSecondary, height: 1.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    this.color = AppColor.mainColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColor.background.withOpacity(.55),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppColor.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
