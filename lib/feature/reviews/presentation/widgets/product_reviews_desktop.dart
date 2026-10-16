import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/product_review_card_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/product_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../view_model/get_reviews/get_reviews_cubit.dart';
import 'review_card.dart';
import 'skeletonizer_review_card.dart';

class ProductReviewsDesktop extends StatelessWidget {
  final ProductEntity product;

  const ProductReviewsDesktop({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ProductReviewCardDesktop(product: product),
              ),
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
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3.1,
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

                    return GridView.builder(
                      itemCount: 6,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3.1,
                          ),
                      itemBuilder: (context, index) {
                        return SkeletonizerReviewCard();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
