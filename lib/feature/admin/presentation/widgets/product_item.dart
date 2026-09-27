import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';

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
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.divider.withOpacity(.45)),
        ),
        child: Row(
          children: [
            // ─────────────────────────────
            // Rank / Medal
            // ─────────────────────────────
            SizedBox(
              width: 38,
              child: Center(
                child: Image.asset(
                  medal,
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // ─────────────────────────────
            // Product Image
            // ─────────────────────────────
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: AppColor.backgroundDark.withOpacity(.45),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColor.divider.withOpacity(.45)),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
                memCacheWidth: 180,
                memCacheHeight: 180,
                fadeInDuration: const Duration(milliseconds: 180),
                placeholder: (context, url) {
                  return Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.mainColor.withOpacity(.35),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.restaurant_rounded,
                    size: 25,
                    color: AppColor.textSecondary.withOpacity(.45),
                  );
                },
              ),
            ),

            const SizedBox(width: 13),

            // ─────────────────────────────
            // Product Information
            // ─────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font13Weight600(context).copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 13,
                        color: AppColor.textSecondary.withOpacity(.75),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$orderCount طلب',
                        style: StyleManager.font12Weight500(context).copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ─────────────────────────────
            // Orders Statistics
            // ─────────────────────────────
            Container(
              constraints: const BoxConstraints(minWidth: 70),
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.07),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: AppColor.mainColor.withOpacity(.10)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        orderCount,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColor.mainColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        Assets.assets.images.rise.path,
                        width: 11,
                        height: 11,
                        color: AppColor.mainColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'طلب',
                    style: StyleManager.font12Weight500(context).copyWith(
                      color: AppColor.textSecondary,
                      fontSize: 9,
                      height: 1,
                    ),
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
