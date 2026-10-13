import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/order_review_model.dart';

abstract class OrderReviewsRepo {
  Stream<Either<Failure, List<OrderReviewModel>>> getReviews();

  Future<Either<Failure, void>> deleteReview(String reviewId);
}