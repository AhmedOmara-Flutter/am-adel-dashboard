part of 'get_coupon_cubit.dart';

@immutable
sealed class GetCouponState {}

final class GetCouponInitial extends GetCouponState {}

final class GetCouponLoading extends GetCouponState {}

final class GetCouponSuccess extends GetCouponState {
  final List<UserCouponEntity> userCoupons;

  GetCouponSuccess(this.userCoupons);
}

final class GetCouponFailure extends GetCouponState {
  final String message;

  GetCouponFailure(this.message);
}