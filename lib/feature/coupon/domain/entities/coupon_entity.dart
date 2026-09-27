import 'package:equatable/equatable.dart';

class CouponEntity extends Equatable {
final String id;
final String code;
final String discountType;
final double discountValue;
final double minimumOrder;
final double maxDiscount;
final DateTime createdAt;
final DateTime expiresAt;
final bool used;
final DateTime? usedAt;
final String? orderId;

const CouponEntity({
required this.id,
required this.code,
required this.discountType,
required this.discountValue,
required this.minimumOrder,
required this.maxDiscount,
required this.createdAt,
required this.expiresAt,
this.used = false,
this.usedAt,
this.orderId,
});

@override
List<Object?> get props => [
id,
code,
discountType,
discountValue,
minimumOrder,
maxDiscount,
createdAt,
expiresAt,
used,
usedAt,
orderId,
];
}
