import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/bundle_offer_entity.dart';

class BundleOfferModel extends BundleOfferEntity {
  const BundleOfferModel({
    super.imageUrl,
    required super.title,
    required super.description,
    required super.price,
    super.image,
    super.id,
    required super.createdAt,
  });

  factory BundleOfferModel.fromJson(Map<String, dynamic> json) {
    return BundleOfferModel(
      image: json['image'] as String?,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      id: json['id'] ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory BundleOfferModel.fromEntity(BundleOfferEntity entity) {
    return BundleOfferModel(
      imageUrl: entity.imageUrl,
      image: entity.image,
      title: entity.title,
      description: entity.description,
      price: entity.price,
      id: entity.id,
      createdAt: entity.createdAt,
    );
  }

  BundleOfferEntity toEntity() {
    return BundleOfferEntity(
      imageUrl: imageUrl,
      image: image,
      title: title,
      description: description,
      price: price,
      id: id,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'price': price,
      'id': id,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}