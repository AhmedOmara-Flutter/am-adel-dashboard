import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/database_services.dart';
import '../models/order_review_model.dart';
import '../../domain/repos/order_review_repo.dart';

class OrderReviewsRepoImpl implements OrderReviewsRepo {
  final DatabaseServices _databaseServices;

  OrderReviewsRepoImpl(this._databaseServices);

  @override
  Stream<Either<Failure, List<OrderReviewModel>>> getReviews() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'order_reviews',
      )) {
        if (data is! List) {
          throw Exception('تعذر تحميل تقييمات العملاء');
        }

        final reviews = data
            .whereType<Map<String, dynamic>>()
            .map(OrderReviewModel.fromJson)
            .toList();

        reviews.sort(
              (a, b) => b.createdAt.compareTo(a.createdAt),
        );

        final usersCache = <String, Map<String, dynamic>?>{};
        final reviewsWithCustomers = <OrderReviewModel>[];

        for (final review in reviews) {
          String? customerName;
          String? customerPhone;

          final userId = review.userId.trim();

          if (userId.isNotEmpty) {
            try {
              if (!usersCache.containsKey(userId)) {
                final userData = await _databaseServices.getData(
                  path: 'users',
                  uId: userId,
                );

                usersCache[userId] = userData is Map
                    ? Map<String, dynamic>.from(userData)
                    : null;
              }

              final userData = usersCache[userId];

              if (userData != null) {
                customerName = _readString(userData, [
                  'userName',
                  'name',
                  'fullName',
                  'username',
                ]);

                customerPhone = _readString(userData, [
                  'phone',
                  'phoneNumber',
                  'mobile',
                  'mobileNumber',
                ]);
              }
            } catch (_) {
              customerName = null;
              customerPhone = null;
            }
          }

          reviewsWithCustomers.add(
            OrderReviewModel(
              id: review.id,
              orderId: review.orderId,
              userId: review.userId,
              customerName: customerName,
              customerPhone: customerPhone,
              foodRating: review.foodRating,
              foodReview: review.foodReview,
              driverRating: review.driverRating,
              driverReview: review.driverReview,
              createdAt: review.createdAt,
            ),
          );
        }

        yield Right(reviewsWithCustomers);
      }
    } catch (e) {
      yield Left(
        ServerFailure(
          errMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteReview(String reviewId) async {
    try {
      if (reviewId.trim().isEmpty) {
        throw Exception('معرّف التقييم غير صالح');
      }

      await _databaseServices.deleteData(
        path: 'order_reviews',
        uId: reviewId,
      );

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  String? _readString(
      Map<String, dynamic> data,
      List<String> keys,
      ) {
    for (final key in keys) {
      final value = data[key];

      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return null;
  }
}