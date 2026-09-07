import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
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
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 15
      ),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(

        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.05),
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

          SizedBox(width: 12),

          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.mainColor.withOpacity(.12),
                  AppColor.mainColor.withOpacity(.05),
                ],
              ),
              border: Border.all(
                color: AppColor.mainColor.withOpacity(.15),
              ),
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productName,
                  style: StyleManager.font13Weight600(context).copyWith(
                    color: AppColor.mainColor
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  '$orderCount طلب',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orderCount,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image.asset(
                      Assets.assets.images.rise.path,
                      height: 10,
                      width: 10,
                      color: AppColor.mainColor,
                    ),
                  ],
                ),

                SizedBox(height: 2),

                Text(
                  'إجمالي الطلبات',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
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