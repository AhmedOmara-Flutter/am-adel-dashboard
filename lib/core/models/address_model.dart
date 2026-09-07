
import 'package:am_adel_dashboard/core/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.name,
    required super.phone,
    required super.address,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
    };
  }

  // from Entity
  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
    );
  }

  // to Entity
  AddressEntity toEntity() {
    return AddressEntity(
      name: name,
      phone: phone,
      address: address,
    );
  }

}
