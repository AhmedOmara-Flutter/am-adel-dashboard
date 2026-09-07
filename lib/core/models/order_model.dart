import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/models/selected_location_model.dart';
import 'package:am_adel_dashboard/core/models/user_model.dart';

import '../../feature/cart_status/domain/entities/cart_entity.dart';
import '../enums/order_enum.dart';
import 'address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  final String uId;
  final String paymentMethod;
  final DateTime createdAt;
  final num totalPrice;
  final AddressModel address;
  final List<OrderItemModel> items;
  final UserModel userModel;
  final OrderStatus status;
  String? id;
  final SelectedLocationModel selectedLocation;
  String? orderNote;
  String? paymentImage;


  OrderModel({
    required this.uId,
    required this.paymentMethod,
    required this.address,
    required this.items,
    required this.totalPrice,
    required this.createdAt,
    required this.userModel,
    required this.status,
    this.id,
    required this.selectedLocation,
    this.orderNote,
    this.paymentImage,
  });

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      uId: entity.uId,
      paymentMethod: entity.isCashOnDelivery == true ? 'Cash' : 'Online',
      createdAt: DateTime.now(),
      address: AddressModel.fromEntity(entity.addressEntity!),
      totalPrice: entity.cartEntity.getTotalPrice(),
      items: entity.cartEntity.cartItems
          .map((cartItem) => OrderItemModel.fromEntity(cartItem))
          .toList(),
      userModel: UserModel.fromEntity(entity.userEntity!),
      status: entity.status,
      id: entity.id,
      selectedLocation: SelectedLocationModel.fromEntity(
        entity.selectedLocationEntity!,
      ),
      orderNote: entity.orderNote,
      paymentImage: entity.paymentImage,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      uId: uId,
      createdAt: createdAt,
      isCashOnDelivery: paymentMethod == 'Cash' ? true : false,
      addressEntity: address.toEntity(),
      cartEntity: CartEntity(
        cartItems: items.map((item) => item.toEntity()).toList(),
      ),
      userEntity: userModel.toEntity(),
      status: status,
      id: id,
      selectedLocationEntity: selectedLocation.toEntity(),
      orderNote: orderNote,
      paymentImage: paymentImage,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      uId: json['uId'],
      totalPrice: json['totalPrice'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      address: AddressModel.fromJson(json['address']),
      paymentMethod: json['paymentMethod'],
      items: List<OrderItemModel>.from(
        json['items'].map((item) => OrderItemModel.fromJson(item)),
      ),
      userModel: UserModel.fromJson(json['userModel']),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == (json['status']),
        orElse: () => OrderStatus.pending,
      ),
      id: json['id'],
      selectedLocation: SelectedLocationModel.fromJson(
        json['selectedLocation'],
      ),
      orderNote: json['orderNote'],
      paymentImage: json['paymentImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'createdAt': createdAt,
      'address': address.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'userModel': userModel.toJson(),
      'status': status.name,
      'id': id,
      'selectedLocation': selectedLocation.toJson(),
      'orderNote': orderNote,
      'paymentImage': paymentImage,
    };
  }
}
