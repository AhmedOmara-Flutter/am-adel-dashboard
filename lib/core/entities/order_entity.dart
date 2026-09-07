import 'package:am_adel_dashboard/core/entities/address_entity.dart';
import 'package:am_adel_dashboard/feature/cart_status/domain/entities/cart_entity.dart';
import 'package:am_adel_dashboard/core/entities/selected_location_entity.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';

import '../enums/order_enum.dart';

class OrderEntity {
  final String uId;
   String ?id;
  final DateTime? createdAt;
  final CartEntity cartEntity;
  bool? isCashOnDelivery;
  AddressEntity? addressEntity;
  UserEntity?userEntity;
  final OrderStatus status;
  SelectedLocationEntity ?selectedLocationEntity;
  String? orderNote;
  String? paymentImage;





  OrderEntity({
    required this.cartEntity,
    this.isCashOnDelivery,
    this.addressEntity,
    required this.uId,
    this.createdAt,
    this.userEntity,required this.status,
     this.id,
    this.selectedLocationEntity,
    this.orderNote,
    this.paymentImage,
  });

  OrderEntity copyWith({
    String? uId,
    String? id,
    DateTime? createdAt,
    CartEntity? cartEntity,
    bool? isCashOnDelivery,
    AddressEntity? addressEntity,
    UserEntity? userEntity,
    OrderStatus? status,
    SelectedLocationEntity? selectedLocationEntity,
    String? orderNote,
    String? paymentImage,
  }) {
    return OrderEntity(
      uId: uId ?? this.uId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      cartEntity: cartEntity ?? this.cartEntity,
      isCashOnDelivery: isCashOnDelivery ?? this.isCashOnDelivery,
      addressEntity: addressEntity ?? this.addressEntity,
      userEntity: userEntity ?? this.userEntity,
      status: status ?? this.status,
      selectedLocationEntity:
      selectedLocationEntity ?? this.selectedLocationEntity,
      orderNote: orderNote ?? this.orderNote,
      paymentImage: paymentImage ?? this.paymentImage,


    );
  }
  String getFullAddress() {
    return '${addressEntity!.address}';
  }

  double getTotalDeliveryCost(List<OrderEntity> orders) {
    double total = 0;

    for (final order in orders) {
      total += order.selectedLocationEntity?.cost ?? 0;
    }

    return total;
  }
}
