import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repos/coupon_repo.dart';
part 'delete_coupon_state.dart';

class DeleteCouponCubit extends Cubit<DeleteCouponState> {
  final CouponRepo couponRepo;

  DeleteCouponCubit(this.couponRepo) : super(DeleteCouponInitial());

  Future<void> deleteCoupon({
    required String userId,
    required String couponCode,
  }) async {
    emit(DeleteCouponLoading());

    final result = await couponRepo.deleteCoupon(
      userId,
      couponCode,
    );

    result.fold(
          (failure) => emit(
        DeleteCouponFailure(failure.errMessage),
      ),
          (_) => emit(DeleteCouponSuccess()),
    );
  }
}