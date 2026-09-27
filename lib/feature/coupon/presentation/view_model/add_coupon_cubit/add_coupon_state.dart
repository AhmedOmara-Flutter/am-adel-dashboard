part of 'add_coupon_cubit.dart';

@immutable
sealed class AddCouponState {}

final class AddCouponInitial extends AddCouponState {}

final class AddCouponLoading extends AddCouponState {}

final class AddCouponSuccess extends AddCouponState {}

final class AddCouponFailure extends AddCouponState {
  final String message;

  AddCouponFailure(this.message);
}