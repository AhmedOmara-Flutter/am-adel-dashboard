import 'dart:io';

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String ?id;
  final String name;
  final String code;
  final num price;
  final String description;
  final File ?imageFile;
  final bool isFeatured;
  String? image;
  final num expirationMonth;
  final num unitAmount;
  final num numberOfCalories;
  final bool isOrganic;
  final int sellingCount;
  final List<File> ?subImagesFiles;
  List<String> ?subImages;
  double averageRating;
  int reviewsCount;
  double ratingSum;
  final String category;
  final String ?size;
  final String createdAt;
  String? offerId;
  final bool isPaused;


  ProductEntity copyWith({
    String? id,
    String? name,
    String? code,
    num? price,
    String? description,
    File? imageFile,
    bool? isFeatured,
    String? image,
    num? expirationMonth,
    num? unitAmount,
    num? numberOfCalories,
    bool? isOrganic,
    int? sellingCount,
    List<File>? subImagesFiles,
    List<String>? subImages,
    String? category,
    String? createdAt,
    double? averageRating,
    int? reviewsCount,
    double? ratingSum,
    String? offerId,
    String? size,
    bool? isPaused,


  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      description: description ?? this.description,
      imageFile: imageFile ?? this.imageFile,
      isFeatured: isFeatured ?? this.isFeatured,
      image: image ?? this.image,
      expirationMonth: expirationMonth ?? this.expirationMonth,
      unitAmount: unitAmount ?? this.unitAmount,
      numberOfCalories:
      numberOfCalories ?? this.numberOfCalories,
      isOrganic: isOrganic ?? this.isOrganic,
      sellingCount: sellingCount ?? this.sellingCount,
      subImagesFiles:
      subImagesFiles ?? this.subImagesFiles,
      subImages: subImages ?? this.subImages,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      averageRating:
      averageRating ?? this.averageRating,
      reviewsCount:
      reviewsCount ?? this.reviewsCount,
      ratingSum: ratingSum ?? this.ratingSum,
      offerId: offerId ?? this.offerId,
      size: size ?? this.size,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  ProductEntity({
    required this.name,
    required this.code,
    required this.price,
    required this.description,
     this.imageFile,
    required this.isFeatured,
    this.image,
    required this.expirationMonth,
    required this.unitAmount,
    required this.numberOfCalories,
    this.isOrganic = false,
    this.sellingCount = 0,
     this.subImagesFiles,
    this.subImages,
    required this.category,
    required this.createdAt,
    this.id,
    this.averageRating = 0.0,
    this.reviewsCount = 0,
    this.ratingSum = 0.0,
    this.offerId,
    this.size,
    this.isPaused = false,
  });

  @override
  List<Object?> get props => [id];
}


