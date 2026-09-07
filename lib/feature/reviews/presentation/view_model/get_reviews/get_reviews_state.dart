part of 'get_reviews_cubit.dart';

@immutable
sealed class GetReviewsState {}
final class GetReviewsInitial extends GetReviewsState {}
final class ReviewInitial extends GetReviewsState {}

final class ReviewLoading extends GetReviewsState {}
final class ReviewError extends GetReviewsState {
  final String errMessage;

  ReviewError(this.errMessage);
}
final class ReviewSuccess extends GetReviewsState {
  final List<ReviewEntity> reviews;

  ReviewSuccess(this.reviews);
}

final class DeleteAllReviewsFailure extends GetReviewsState {
  final String errMessage;

  DeleteAllReviewsFailure(this.errMessage);
}
final class DeleteAllReviewsLoading extends GetReviewsState {}
final class DeleteAllReviewsSuccess extends GetReviewsState {}
