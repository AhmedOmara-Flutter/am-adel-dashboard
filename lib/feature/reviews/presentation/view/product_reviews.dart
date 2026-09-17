import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/product_reviews_body.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/entities/product_entity.dart';

class ProductReviewsView extends StatelessWidget {
 final ProductEntity product;
  const ProductReviewsView({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const CustomBackButton(),
        ),
        centerTitle: true,
        title: Text(
          'التعليقات',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(
            color: AppColor.textOnDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ProductReviewsViewBody(product: product,),
    );
  }
}
