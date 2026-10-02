import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Image.asset(
                medal,
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
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
                memCacheWidth: 180,
                memCacheHeight: 180,
                fadeInDuration: const Duration(
                  milliseconds: 150,
                ),
                placeholder: (context, url) {
                  return Center(
                    child: SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.mainColor.withOpacity(.25),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.restaurant_rounded,
                    color: AppColor.textSecondary.withOpacity(.35),
                    size: 23,
                  );
                },
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    productName,
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
                        '$orderCount مبيعات',
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
                  orderCount,
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
    );
  }

  double _getProgress() {
    final count = int.tryParse(orderCount) ?? 0;

    if (count <= 0) {
      return 0.05;
    }

    return (count / (count + 100)).clamp(0.08, 0.95);
  }
}
