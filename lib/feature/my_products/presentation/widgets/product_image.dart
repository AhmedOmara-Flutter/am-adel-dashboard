import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductImage extends StatelessWidget {
  final ProductEntity product;
  const ProductImage(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: CachedNetworkImage(
        imageUrl: product.image??'',
        width: 80,
        height: 80,
        fit: BoxFit.contain,
        placeholder: (context, url) =>
            Skeletonizer(child: Container(
            ),),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
