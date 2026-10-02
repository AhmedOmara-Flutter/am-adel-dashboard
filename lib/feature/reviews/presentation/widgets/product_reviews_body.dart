import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/config_size.dart';

import '../../../../core/entities/product_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../view_model/get_reviews/get_reviews_cubit.dart';
import 'product_review_card.dart';
import 'review_card.dart';
import 'skeletonizer_review_card.dart';

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

class ProductReviewsDesktop extends StatelessWidget {
  final ProductEntity product;

  const ProductReviewsDesktop({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductReviewCardDesktop(product: product),
                const SizedBox(width: 20),
                Expanded(
                  child: BlocBuilder<GetReviewsCubit, GetReviewsState>(
                    builder: (context, state) {
                      if (state is ReviewError) {
                        return Center(
                          child: Text(
                            state.errMessage,
                            style: const TextStyle(color: AppColor.red),
                          ),
                        );
                      }

                      if (state is ReviewSuccess) {
                        final reviews = state.reviews;

                        if (reviews.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد تعليقات حالياً',
                              style: TextStyle(color: AppColor.textSecondary),
                            ),
                          );
                        }

                        return GridView.builder(
                          itemCount: reviews.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 5,
                              ),
                          itemBuilder: (context, index) {
                            return ReviewCard(
                              review: ReviewEntity(
                                name: reviews[index].name,
                                reviewDescription:
                                    reviews[index].reviewDescription,
                                rating: reviews[index].rating,
                                date: reviews[index].date,
                              ),
                            );
                          },
                        );
                      }

                      return ListView.separated(
                        itemCount: 5,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return const SkeletonizerReviewCard();
                        },
                      );
                    },
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

class ProductReviewsMobile extends StatelessWidget {
  final ProductEntity product;

  const ProductReviewsMobile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ProductReviewCardMobile(product: product),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: BlocBuilder<GetReviewsCubit, GetReviewsState>(
              builder: (context, state) {

                if (state is ReviewError) {
                  return Center(
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(color: AppColor.red),
                    ),
                  );
                }

                if (state is ReviewSuccess) {
                  final reviews = state.reviews;

                  if (reviews.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا يوجد تعليقات حالياً',
                        style: TextStyle(color: AppColor.textSecondary),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return ReviewCard(
                        review: ReviewEntity(
                          name: reviews[index].name,
                          reviewDescription: reviews[index].reviewDescription,
                          rating: reviews[index].rating,
                          date: reviews[index].date,
                        ),
                      );
                    },
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return const SkeletonizerReviewCard();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
