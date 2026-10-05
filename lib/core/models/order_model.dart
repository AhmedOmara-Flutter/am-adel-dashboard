import 'package:am_adel_dashboard/feature/selected_location/data/models/selected_location_model.dart';
import 'package:am_adel_dashboard/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../feature/cart_status/domain/entities/cart_entity.dart';
import '../entities/order_entity.dart';
import '../enums/order_enum.dart';
import 'address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  String? id;

  final String uId;

  final String paymentMethod;

  final DateTime createdAt;

  final num totalPrice;

  final num couponDiscount;

  final UserModel userModel;

  final AddressModel address;

  final SelectedLocationModel selectedLocation;

  final List<OrderItemModel> items;

  final OrderStatus status;

  String? paymentImage;

  String? orderNote;

  OrderModel({
    required this.uId,
    required this.paymentMethod,
    required this.address,
    required this.items,
    required this.totalPrice,
    required this.couponDiscount,
    required this.createdAt,
    this.id,
    required this.userModel,
    required this.status,
    required this.selectedLocation,
    this.paymentImage,
    this.orderNote,
  });

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      uId: entity.uId,

      id: entity.id,

      paymentMethod: entity.isCashOnDelivery == true ? 'Cash' : 'Online',

      createdAt: DateTime.now(),

      address: AddressModel.fromEntity(entity.addressEntity!),

      totalPrice: entity.totalPrice,

      couponDiscount: entity.couponDiscount,

      items: entity.cartEntity.cartItems
          .map((cartItem) => OrderItemModel.fromEntity(cartItem))
          .toList(),

      userModel: UserModel.fromEntity(entity.userEntity!),

      status: entity.status,

      selectedLocation: SelectedLocationModel.fromEntity(
        entity.selectedLocationEntity!,
      ),

      paymentImage: entity.paymentImage,

      orderNote: entity.orderNote,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,

      uId: uId,

      createdAt: createdAt,

      isCashOnDelivery: paymentMethod == 'Cash',

      addressEntity: address.toEntity(),

      cartEntity: CartEntity(
        cartItems: items.map((item) => item.toEntity()).toList(),
      ),

      userEntity: userModel.toEntity(),

      status: status,

      selectedLocationEntity: selectedLocation.toEntity(),

      paymentImage: paymentImage,

      orderNote: orderNote,

      totalPrice: totalPrice.toDouble(),

      couponDiscount: couponDiscount.toDouble(),
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      uId: json['uId'],

      id: json['id'],

      totalPrice: json['totalPrice'] ?? 0,

      couponDiscount: json['couponDiscount'] ?? 0,

      createdAt: (json['createdAt'] as Timestamp).toDate(),

      address: AddressModel.fromJson(json['address']),

      paymentMethod: json['paymentMethod'],

      items: List<OrderItemModel>.from(
        json['items'].map((item) => OrderItemModel.fromJson(item)),
      ),

      userModel: UserModel.fromJson(json['userModel']),

      status: OrderStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),

      selectedLocation: SelectedLocationModel.fromJson(
        json['selectedLocation'],
      ),

      paymentImage: json['paymentImage'],

      orderNote: json['orderNote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,

      'paymentMethod': paymentMethod,

      'totalPrice': totalPrice,

      'couponDiscount': couponDiscount,

      'createdAt': createdAt,

      'address': address.toJson(),

      'items': items.map((item) => item.toJson()).toList(),

      'id': id,

      'userModel': userModel.toJson(),

      'status': status.name,

      'selectedLocation': selectedLocation.toJson(),

      'paymentImage': paymentImage,

      'orderNote': orderNote,
    };
  }
}
