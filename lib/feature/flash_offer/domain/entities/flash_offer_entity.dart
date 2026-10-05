import 'dart:io';

class FlashOfferEntity {
  final String? id;
  final File? imageUrl;
  final String? image;
  final DateTime createdAt;

  const FlashOfferEntity({
    this.id,
    this.imageUrl,
    this.image,
    required this.createdAt,
  });
}