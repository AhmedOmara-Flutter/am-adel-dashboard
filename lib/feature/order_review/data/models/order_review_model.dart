
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/order_review_entity.dart';

class OrderReviewModel extends OrderReviewEntity {
  const OrderReviewModel({
    super.id,
    required super.orderId,
    required super.userId,
    super.customerName,
    super.customerPhone,
    required super.foodRating,
    required super.foodReview,
    required super.driverRating,
    required super.driverReview,
    required super.createdAt,
  });

  factory OrderReviewModel.fromJson(Map<String, dynamic> json) {
    return OrderReviewModel(
      id: json['id'] as String?,
      orderId: json['orderId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      foodRating: (json['foodRating'] as num?)?.toInt() ?? 0,
      foodReview: json['foodReview'] as String? ?? '',
      driverRating: (json['driverRating'] as num?)?.toInt() ?? 0,
      driverReview: json['driverReview'] as String? ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  factory OrderReviewModel.fromEntity(OrderReviewEntity entity) {
    return OrderReviewModel(
      id: entity.id,
      orderId: entity.orderId,
      userId: entity.userId,
      customerName: entity.customerName,
      customerPhone: entity.customerPhone,
      foodRating: entity.foodRating,
      foodReview: entity.foodReview,
      driverRating: entity.driverRating,
      driverReview: entity.driverReview,
      createdAt: entity.createdAt,
    );
  }

  OrderReviewEntity toEntity() {
    return OrderReviewEntity(
      id: id,
      orderId: orderId,
      userId: userId,
      customerName: customerName,
      customerPhone: customerPhone,
      foodRating: foodRating,
      foodReview: foodReview,
      driverRating: driverRating,
      driverReview: driverReview,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'foodRating': foodRating,
      'foodReview': foodReview,
      'driverRating': driverRating,
      'driverReview': driverReview,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
