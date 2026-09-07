import 'package:am_adel_dashboard/feature/cart_status/domain/entities/cart_entity.dart';

import 'cart_item_model.dart';

class CartModel extends CartEntity {
  const CartModel({required super.cartItems});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartItems: (json['cartItems'] as List)
          .map((e) => CartItemModel.fromJson(e).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItems': cartItems
          .map((e) => CartItemModel.fromEntity(e).toJson())
          .toList(),
    };
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(cartItems: entity.cartItems);
  }

  CartEntity toEntity() {
    return CartEntity(cartItems: cartItems);
  }
}