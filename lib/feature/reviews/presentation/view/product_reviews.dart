import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/product_reviews_body.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/entities/product_entity.dart';

class ProductReviewsView extends StatelessWidget {
 final ProductEntity product;
  const ProductReviewsView({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'التعليقات',
        buttonType: AppBarButtonType.back,
      ),
      body: ProductReviewsViewBody(product: product,),
    );
  }
}
