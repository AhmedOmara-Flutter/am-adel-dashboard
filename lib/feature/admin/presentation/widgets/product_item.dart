import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productName,
    required this.orderCount,
    required this.image,
    required this.medal,
  });

  final String productName;
  final String orderCount;
  final String image;
  final String medal;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 34,
              child: Image.asset(
                medal,
                width: 25,
                height: 25,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(width: 8),

            Container(
              width: 58,
              height: 58,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor.cardLight,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
                memCacheWidth: 180,
                memCacheHeight: 180,
                fadeInDuration: const Duration(milliseconds: 150),
                placeholder: (context, url) {
                  return Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.mainColor.withOpacity(.3),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.restaurant_rounded,
                    color: AppColor.textSecondary.withOpacity(.4),
                    size: 25,
                  );
                },
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font13Weight600(context).copyWith(
                      color: AppColor.textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 12,
                        color: AppColor.textSecondary.withOpacity(.65),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$orderCount مبيعات',
                        style: StyleManager.font12Weight500(context).copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      minHeight: 4,
                      value: _getProgress(),
                      backgroundColor:
                      AppColor.backgroundDark.withOpacity(.6),
                      valueColor: AlwaysStoppedAnimation(
                        AppColor.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  orderCount,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColor.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'طلب',
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textSecondary,
                    fontSize: 8.5,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getProgress() {
    final count = int.tryParse(orderCount) ?? 0;

    if (count <= 0) return 0.05;

    return (count / (count + 100)).clamp(0.08, 0.95);
  }
}