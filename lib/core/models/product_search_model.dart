
import 'package:am_adel_dashboard/core/entities/product_search_entity.dart';

class SearchProductModel extends SearchProductEntity {
  const SearchProductModel({
    required super.name,
    required super.code,
    required super.price,
    super.image,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'],
    );
  }

  SearchProductEntity toEntity() {
    return SearchProductEntity(
      name: name,
      code: code,
      price: price,
      image: image,
    );
  }
}