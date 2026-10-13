import 'dart:async';
import '../../../../../core/utils/app_imports.dart';
import '../../../data/models/order_review_model.dart';
import '../../../data/repos/order_review_repo.dart';

part 'order_review_state.dart';

class OrderReviewCubit extends Cubit<OrderReviewState> {
  OrderReviewCubit(this._repo) : super(OrderReviewInitial());

  final OrderReviewsRepo _repo;

  List<OrderReviewModel> reviews = [];

  StreamSubscription? _reviewsSubscription;
  bool _isLoading = false;
  bool _isDeleting = false;

  Future<void> getReviews() async {
    if (_isLoading || isClosed) return;

    _isLoading = true;
    emit(OrderReviewLoading());

    await _reviewsSubscription?.cancel();

    _reviewsSubscription = _repo.getReviews().listen(
          (result) {
        if (isClosed) return;

        result.fold(
              (failure) {
            emit(OrderReviewError(failure.errMessage));
          },
              (reviewsList) {
            reviews = reviewsList;
            emit(OrderReviewSuccess(reviewsList));
          },
        );
      },
      onError: (error) {
        if (!isClosed) {
          emit(OrderReviewError(error.toString()));
        }
      },
      onDone: () {
        _isLoading = false;
      },
    );
  }


  Future<void> deleteReview(String reviewId) async {
    if (_isDeleting || isClosed) return;

    _isDeleting = true;

    final result = await _repo.deleteReview(reviewId);

    if (isClosed) return;

    result.fold(
          (failure) {
        emit(OrderReviewError(failure.errMessage));
      },
          (_) {
        reviews.removeWhere((review) => review.id == reviewId);
        emit(OrderReviewSuccess(List<OrderReviewModel>.from(reviews)));
      },
    );

    _isDeleting = false;
  }

  @override
  Future<void> close() async {
    await _reviewsSubscription?.cancel();
    return super.close();
  }
}
