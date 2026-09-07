import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/repos/reviews_repo/review_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/product_entity.dart';

part 'get_product_with_reviews_state.dart';

class GetProductWithReviewsCubit extends Cubit<GetProductWithReviewsState> {
  GetProductWithReviewsCubit(this._reviewRepo) : super(GetProductWithReviewsInitial());
  final ReviewRepo _reviewRepo;
  final List<ProductEntity> products = [];
  StreamSubscription? _productsSubscription;

  void getProductsWithReviews() {
    emit(GetProductsWithReviewsLoading());

    _productsSubscription?.cancel();
    _productsSubscription = _reviewRepo.getProductsWithReviews().listen((data) {
      data.fold(
        (failure) {
          emit(GetProductsWithReviewsError(failure.errMessage));
        },
        (products) {
          this.products.clear();
          this.products.addAll(products);
          emit(GetProductsWithReviewsSuccess(products));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}
