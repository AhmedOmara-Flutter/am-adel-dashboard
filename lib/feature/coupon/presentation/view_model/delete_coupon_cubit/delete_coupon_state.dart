part of 'delete_coupon_cubit.dart';

@immutable
sealed class DeleteCouponState {}

final class DeleteCouponInitial extends DeleteCouponState {}

final class DeleteCouponLoading extends DeleteCouponState {}

final class DeleteCouponSuccess extends DeleteCouponState {}

final class DeleteCouponFailure extends DeleteCouponState {
  final String message;

  DeleteCouponFailure(this.message);
}