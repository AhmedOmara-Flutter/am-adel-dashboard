import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/view_model/get_products_with_review/get_product_with_reviews_cubit.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/reviews_view_body.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetProductWithReviewsCubit>().getProductsWithReviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReviewsViewBody(
      ),
    );
  }
}
