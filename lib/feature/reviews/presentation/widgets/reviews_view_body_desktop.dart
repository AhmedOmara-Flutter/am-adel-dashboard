import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../generated/assets.dart';
import '../view_model/get_products_with_review/get_product_with_reviews_cubit.dart';
import 'review_item.dart';
import 'skeletonizer_review_item.dart';

class ReviewsViewBodyDesktop extends StatelessWidget {
  const ReviewsViewBodyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductWithReviewsCubit, GetProductWithReviewsState>(
      builder: (context, state) {
        if (state is GetProductsWithReviewsError) {
          return Center(
            child: Text(
              state.errMessage,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColor.red),
            ),
          );
        }

        if (state is GetProductsWithReviewsSuccess) {
          if (state.products.isEmpty) {
            return const EmptyWidget();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ReviewItem(product: state.products[index]);
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return SkeletonizerReviewItem();
          },
        );
      },
    );
  }
}
