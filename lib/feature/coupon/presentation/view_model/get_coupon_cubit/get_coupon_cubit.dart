import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/coupon_repo.dart';
import '../../../domain/entities/user_coupon_entity.dart';

part 'get_coupon_state.dart';

class GetCouponCubit extends Cubit<GetCouponState> {
  final CouponRepo couponRepo;

  StreamSubscription? _couponsSubscription;

  GetCouponCubit(this.couponRepo) : super(GetCouponInitial());

  void getCoupons() {
    emit(GetCouponLoading());

    _couponsSubscription?.cancel();

    _couponsSubscription = couponRepo.getCoupons().listen((result) {
      result.fold((failure) => emit(GetCouponFailure(failure.errMessage)), (
        userCoupons,
      ) {
        userCoupons.sort(
          (a, b) => b.coupon.createdAt.compareTo(a.coupon.createdAt),
        );

        emit(GetCouponSuccess(userCoupons));
      });
    });
  }

  @override
  Future<void> close() {
    _couponsSubscription?.cancel();
    return super.close();
  }
}
