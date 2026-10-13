part of 'order_review_cubit.dart';

@immutable
sealed class OrderReviewState {}

final class OrderReviewInitial extends OrderReviewState {}

final class OrderReviewLoading extends OrderReviewState {}

final class OrderReviewSuccess extends OrderReviewState {
  final List<OrderReviewModel> reviews;

  OrderReviewSuccess(this.reviews);
}

final class OrderReviewError extends OrderReviewState {
  final String message;

  OrderReviewError(this.message);
}
