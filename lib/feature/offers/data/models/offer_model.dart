import '../../domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  OfferModel({
    required super.id,
    required super.productId,
    required super.discountPercentage,
    required super.startDate,
    required super.endDate,
    required super.image,
    required super.name,
    required super.priceBeforeDiscount,
    required super.priceAfterDiscount,
  });

  factory OfferModel.fromEntity(OfferEntity entity) {
    return OfferModel(
      id: entity.id,
      productId: entity.productId,
      discountPercentage: entity.discountPercentage,
      startDate: entity.startDate,
      endDate: entity.endDate,
      image: entity.image,
      name: entity.name,
      priceBeforeDiscount: entity.priceBeforeDiscount,
      priceAfterDiscount: entity.priceAfterDiscount,
    );
  }

  OfferEntity toEntity() {
    return OfferEntity(
      id: id,
      productId: productId,
      discountPercentage: discountPercentage,
      startDate: startDate,
      endDate: endDate,
      image: image,
      name: name,
      priceBeforeDiscount: priceBeforeDiscount,
      priceAfterDiscount: priceAfterDiscount,
    );
  }


  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      productId: json['product_id'],
      discountPercentage: json['discount_percentage'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      image: json['image'],
      name: json['name'],
      priceBeforeDiscount: json['price_before_discount'],
      priceAfterDiscount: json['price_after_discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'discount_percentage': discountPercentage,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'image': image,
      'name': name,
      'price_before_discount': priceBeforeDiscount,
      'price_after_discount': priceAfterDiscount,
    };
  }
}
