import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';

import '../../../../../core/utils/app_color.dart';

class ProductInfo extends StatelessWidget {
  final ProductEntity product;

  const ProductInfo(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 6),
        Text(
          product.description,
          style: Theme.of(context).textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),

        Row(

          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '${product.price} جنيه',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColor.mainColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
