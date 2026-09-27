import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import '../../feature/coupon/data/models/coupon_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userName,
    required super.email,
    required super.uId,
    required super.phone,
    required super.password,
    required super.createdAt,
    super.coupons,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final couponsData = json['coupons'] as List? ?? [];

    return UserModel(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      uId: json['uId'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      coupons: couponsData
          .map(
            (coupon) => CouponModel.fromJson(
          Map<String, dynamic>.from(coupon),
        ).toEntity(),
      )
          .toList(),
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      userName: user.userName,
      email: user.email,
      uId: user.uId,
      phone: user.phone,
      password: user.password,
      createdAt: user.createdAt,
      coupons: user.coupons,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userName: userName,
      email: email,
      uId: uId,
      phone: phone,
      password: password,
      createdAt: createdAt,
      coupons: coupons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'uId': uId,
      'phone': phone,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'coupons': coupons
          .map(
            (coupon) => CouponModel.fromEntity(coupon).toJson(),
      )
          .toList(),
    };
  }
}