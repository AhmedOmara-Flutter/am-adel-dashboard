import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  const CouponModel({
    required super.id,
    required super.code,
    required super.discountType,
    required super.discountValue,
    required super.minimumOrder,
    required super.maxDiscount,
    required super.createdAt,
    required super.expiresAt,
    super.used,
    super.usedAt,
    super.orderId,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      discountType: json['discountType']?.toString() ?? 'percentage',
      discountValue: (json['discountValue'] as num?)?.toDouble() ?? 0.0,
      minimumOrder: (json['minimumOrder'] as num?)?.toDouble() ?? 0.0,
      maxDiscount: (json['maxDiscount'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
      expiresAt: json['expiresAt'] is Timestamp
          ? (json['expiresAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
      used: json['used'] is bool ? json['used'] as bool : false,
      usedAt: json['usedAt'] is Timestamp
          ? (json['usedAt'] as Timestamp).toDate()
          : null,
      orderId: json['orderId']?.toString(),
    );
  }
  factory CouponModel.fromEntity(CouponEntity entity) {
    return CouponModel(
      id: entity.id,
      code: entity.code,
      discountType: entity.discountType,
      discountValue: entity.discountValue,
      minimumOrder: entity.minimumOrder,
      maxDiscount: entity.maxDiscount,
      createdAt: entity.createdAt,
      expiresAt: entity.expiresAt,
      used: entity.used,
      usedAt: entity.usedAt,
      orderId: entity.orderId,
    );
  }

  CouponEntity toEntity() {
    return CouponEntity(
      id: id,
      code: code,
      discountType: discountType,
      discountValue: discountValue,
      minimumOrder: minimumOrder,
      maxDiscount: maxDiscount,
      createdAt: createdAt,
      expiresAt: expiresAt,
      used: used,
      usedAt: usedAt,
      orderId: orderId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountType': discountType,
      'discountValue': discountValue,
      'minimumOrder': minimumOrder,
      'maxDiscount': maxDiscount,
      'createdAt': Timestamp.fromDate(createdAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'used': used,
      'usedAt': usedAt != null ? Timestamp.fromDate(usedAt!) : null,
      'orderId': orderId,
    };
  }
}
