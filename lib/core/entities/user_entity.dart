
import '../../feature/coupon/domain/entities/coupon_entity.dart';

class UserEntity {
  final String userName;
  final String email;
  final String uId;
  final String phone;
  final String password;
  final DateTime createdAt;
  final List<CouponEntity> coupons;

  UserEntity({
    required this.userName,
    required this.email,
    required this.uId,
    required this.phone,
    required this.password,
    required this.createdAt,
    this.coupons = const [],
  });
}