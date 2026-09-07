part of 'get_product_with_reviews_cubit.dart';

@immutable
sealed class GetProductWithReviewsState {}

final class GetProductWithReviewsInitial extends GetProductWithReviewsState {}

final class GetProductsWithReviewsLoading extends GetProductWithReviewsState {}

final class GetProductsWithReviewsError extends GetProductWithReviewsState {
  final String errMessage;

  GetProductsWithReviewsError(this.errMessage);
}

final class GetProductsWithReviewsSuccess extends GetProductWithReviewsState {
  final List<ProductEntity> products;

  GetProductsWithReviewsSuccess(this.products);
}
