
import 'package:am_adel_dashboard/feature/cart_status/domain/entities/cart_item_entity.dart';

import '../../feature/cart_status/data/models/cart_item_model.dart';

class OrderItemModel {
  final String code;
  final String name;
  final String imageUrl;
  final num unitPrice;
  final int quantity;

  OrderItemModel({
    required this.code,
    required this.name,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
  });

  factory OrderItemModel.fromEntity(CartItemEntity entity) {
    return OrderItemModel(
      code: entity.product.code,
      name: entity.product.name,
      imageUrl: entity.product.image!,
      unitPrice: entity.unitPrice,
      quantity: entity.quantity,
    );
  }


  CartItemEntity toEntity() {
    return CartItemModel.fromJson({
      'product': {
        'code': code,
        'name': name,
        'image': imageUrl,
      },
      'unitPrice': unitPrice,
      'quantity': quantity,
    }).toEntity();
  }
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      code: json['code'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      unitPrice: json['unitPrice'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'imageUrl': imageUrl,
      'unitPrice': unitPrice,
      'quantity': quantity,
    };

  }
}
