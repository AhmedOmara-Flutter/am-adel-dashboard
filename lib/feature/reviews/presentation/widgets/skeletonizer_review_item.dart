import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../generated/assets.dart';

class SkeletonizerReviewItem extends StatelessWidget {
  final ProductEntity product;

  const SkeletonizerReviewItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFF3F5F7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(4),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${product.reviewsCount}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.message, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Column(
              children: [
                Image.asset(
                  product.image??Assets.assets.images.img.path,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text('${product.name}', style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 5,),
                    Text(
                      '${product.averageRating}',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.orange,),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RouteManager.productReviews,arguments: product);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'عرض جميع التعليقات',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
