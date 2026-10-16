import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import '../../domain/entities/review_entity.dart';
import '../view_model/get_reviews/get_reviews_cubit.dart';
import 'product_review_card_mobile.dart';
import 'review_card.dart';
import 'skeletonizer_review_card.dart';

class ProductReviewsMobile extends StatelessWidget {
  final ProductEntity product;

  const ProductReviewsMobile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
            child: ProductReviewCardMobile(product: product),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10,),),
        BlocBuilder<GetReviewsCubit, GetReviewsState>(
          builder: (context, state) {
            if (state is ReviewError) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(color: AppColor.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            if (state is ReviewSuccess) {
              final reviews = state.reviews;

              if (reviews.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'لا يوجد تعليقات حالياً',
                        style: TextStyle(color: AppColor.textSecondary),
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final review = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                    child: ReviewCard(
                      review: ReviewEntity(
                        name: review.name,
                        reviewDescription: review.reviewDescription,
                        rating: review.rating,
                        date: review.date,
                      ),
                    ),
                  );
                }, childCount: reviews.length),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                  child:SkeletonizerReviewCard()
                );
              }, childCount: 5),
            );
          },
        ),
      ],
    );
  }
}
