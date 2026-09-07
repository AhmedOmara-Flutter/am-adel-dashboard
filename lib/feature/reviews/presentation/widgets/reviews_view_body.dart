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

class ReviewsViewBody extends StatelessWidget {
  const ReviewsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: CustomScrollView(
        slivers: [
          BlocBuilder<GetProductWithReviewsCubit,
              GetProductWithReviewsState>(
            builder: (context, state) {
              final products =
                  context.read<GetProductWithReviewsCubit>().products;

              if (state is GetProductsWithReviewsError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errMessage,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ),
                );
              }
              if (products.isEmpty) {
                return const SliverToBoxAdapter(
                  child: EmptyWidget(),
                );
              }

              if (state is GetProductsWithReviewsSuccess) {
                return MediaQuery
                    .sizeOf(context)
                    .width > ConfigSize.phone ? SliverGrid.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) => ReviewItem(
                    product: state.products[index],
                  ),
                  itemCount: state.products.length,
                ) :
                SliverPadding(
                  padding: const EdgeInsets.only(left: 10.0),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.57,
                    ),
                    itemBuilder: (context, index) =>
                        ReviewItem(
                          product: state.products[index],
                        ),
                    itemCount: state.products.length,
                  ),
                );
              }

              return SliverGrid.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.59,
                ),
                itemBuilder: (context, index) =>
                    SkeletonizerReviewItem(
                      product: ProductEntity(
                        name: 'Product Name',
                        code: '0000',
                        price: 0,
                        image: Assets.assets.images.img.path,
                        averageRating: 0,
                        reviewsCount: 0,
                        description: 'Loading...',
                        isFeatured: true,
                        expirationMonth: 0,
                        unitAmount: 0,
                        numberOfCalories: 0,
                        category: 'category',
                        createdAt: '',
                      ),
                    ),
                itemCount: 6,
              );
            },
          ),
        ],
      ),
    );
  }
}