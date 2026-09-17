import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';

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
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 15,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider.withOpacity(.55),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.06),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            medal,
            height: 30,
            width: 30,
          ),

          const SizedBox(width: 12),

          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.backgroundDark.withOpacity(.65),
                  AppColor.cardLight,
                ],
              ),
              border: Border.all(
                color: AppColor.divider.withOpacity(.55),
              ),
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productName,
                  style: StyleManager.font13Weight600(context).copyWith(
                    color: AppColor.mainColor,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$orderCount طلب',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColor.backgroundDark.withOpacity(.55),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.divider.withOpacity(.45),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orderCount,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 5),

                    Image.asset(
                      Assets.assets.images.rise.path,
                      height: 10,
                      width: 10,
                      color: AppColor.mainColor,
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                Text(
                  'إجمالي الطلبات',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                    fontSize: 11,
                    color: AppColor.textSecondary,
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
