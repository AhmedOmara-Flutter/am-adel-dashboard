import 'dart:io';

class BundleOfferEntity {
  final String ?id;
  final File ?imageUrl;
  final String ?image;
  final String title;
  final String description;
  final double price;
  final DateTime createdAt;



  const BundleOfferEntity({
     this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.id,
    required this.createdAt,
  });
}
