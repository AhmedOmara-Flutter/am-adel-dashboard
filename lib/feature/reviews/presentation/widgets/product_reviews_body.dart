import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/product_reviews_desktop.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/product_reviews_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/product_entity.dart';
import '../view_model/get_reviews/get_reviews_cubit.dart';

class ProductReviewsViewBody extends StatefulWidget {
  final ProductEntity product;

  const ProductReviewsViewBody({super.key, required this.product});

  @override
  State<ProductReviewsViewBody> createState() => _ProductReviewsViewBodyState();
}

class _ProductReviewsViewBodyState extends State<ProductReviewsViewBody> {
  @override
  void initState() {
    super.initState();

    context.read<GetReviewsCubit>().getReviews(productId: widget.product.id!);
  }

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? ProductReviewsDesktop(product: widget.product)
        : ProductReviewsMobile(product: widget.product);
  }
}
