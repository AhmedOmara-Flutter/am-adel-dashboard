import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/restaurant_status_entity.dart';

class RestaurantStatusModel extends RestaurantStatusEntity {
  const RestaurantStatusModel({
    required super.isOpen,
    super.updatedAt,
  });

  factory RestaurantStatusModel.fromJson(Map<String, dynamic> json) {
    final updatedAt = json['updatedAt'];

    return RestaurantStatusModel(
      isOpen: json['isOpen'] ?? true,
      updatedAt: updatedAt is Timestamp
          ? updatedAt.toDate()
          : updatedAt is DateTime
          ? updatedAt
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isOpen': isOpen,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}