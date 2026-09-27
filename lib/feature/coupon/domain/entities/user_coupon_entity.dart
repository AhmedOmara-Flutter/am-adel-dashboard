import '../../../../core/entities/user_entity.dart';
import 'coupon_entity.dart';

class UserCouponEntity {
  final UserEntity user;
  final CouponEntity coupon;

  const UserCouponEntity({
    required this.user,
    required this.coupon,
  });
}