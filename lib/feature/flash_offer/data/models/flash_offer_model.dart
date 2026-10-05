import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/flash_offer_entity.dart';

class FlashOfferModel extends FlashOfferEntity {
  const FlashOfferModel({
    super.id,
    super.imageUrl,
    super.image,
    required super.createdAt,
  });

  factory FlashOfferModel.fromJson(Map<String, dynamic> json) {
    return FlashOfferModel(
      image: json['image'] as String?,
      id: json['id'] ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory FlashOfferModel.fromEntity(FlashOfferEntity entity) {
    return FlashOfferModel(
      id: entity.id,
      imageUrl: entity.imageUrl,
      image: entity.image,
      createdAt: entity.createdAt,
    );
  }

  FlashOfferEntity toEntity() {
    return FlashOfferEntity(
      id: id,
      imageUrl: imageUrl,
      image: image,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'id': id,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}