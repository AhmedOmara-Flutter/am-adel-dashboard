import 'package:equatable/equatable.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import '../../../../core/entities/product_entity.dart';
import 'cart_item_entity.dart';

class CartEntity extends Equatable{
  final List<CartItemEntity> cartItems;

  const CartEntity({required this.cartItems});

  void addCartItem(CartItemEntity cartItem) {
    cartItems.add(cartItem);
  }

  void removeCartItem(CartItemEntity cartItem) {
    cartItems.remove(cartItem);
  }

  int getItemsCount() {
    int count = 0;
    for (CartItemEntity cartItem in cartItems) {
      count += cartItem.quantity;
    }
    return count;
  }

  double getTotalPrice() {
    double totalPrice = 0;

    for (CartItemEntity cartItem in cartItems) {
      totalPrice += cartItem.totalPrice;
    }
    return totalPrice;
  }

  bool isExist(ProductEntity product) {
    for (CartItemEntity cartItem in cartItems) {
      if (cartItem.product.code == product.code) return true;
    }
    return false;
  }

  @override
  String toString() {
    return '''
CartEntity(
  totalPrice: ${getTotalPrice()},
  items: $cartItems
)
''';
  }

  @override
  List<Object?> get props => [cartItems];
}
