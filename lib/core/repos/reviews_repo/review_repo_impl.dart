import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/feature/reviews/data/models/review_model.dart';
import 'package:am_adel_dashboard/feature/reviews/domain/entities/review_entity.dart';

import '../../entities/product_entity.dart';
import '../../models/product_model.dart';
import 'review_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  final DatabaseServices _databaseServices;

  ReviewRepoImpl(this._databaseServices);

  Stream<Either<Failure, List<ProductEntity>>> getProductsWithReviews() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
      in _databaseServices.getStreamData(path: 'products')) {
        final productsWithReviews = data.where((
            product) => (product['reviewsCount'] ?? 0) > 0)
            .map<ProductEntity>((e) => ProductModel.fromJson(e).toEntity())
            .toList();

        yield Right(productsWithReviews);
      }
    } catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ReviewEntity>>> getReviews({
    required String productId,
  }) async* {
    try {
      await for (var (data as List<Map<String, dynamic>>) in _databaseServices
          .getStreamData(path: 'products/${productId}/reviews')) {
        final reviews = data
            .map((e) => ReviewModel.fromJson(e).toEntity())
            .toList();
        print('reviews length: ${reviews.length}');
        yield Right(reviews);
      }
    } on Exception catch (e) {
      print(e);
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllReviews({
    required String productId,
  }) async {
    try {
      final reviews = await _databaseServices.getData(
        path: 'products/$productId/reviews',
      ) as List<Map<String, dynamic>>;

      for (final review in reviews) {
        await _databaseServices.deleteData(
          path: 'products/$productId/reviews',
          uId: review['id'],
        );
      }

      await _databaseServices.updateData(
        path: 'products',
        docId: productId,
        data: {
          'reviewsCount': 0,
          'averageRating': 0,
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

}
