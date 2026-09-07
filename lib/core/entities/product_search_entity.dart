import 'package:equatable/equatable.dart';

class SearchProductEntity extends Equatable {
  final String name;
  final String code;
  final num price;
  final String? image;

  const SearchProductEntity({
    required this.name,
    required this.code,
    required this.price,
    this.image,
  });

  @override
  List<Object?> get props => [code];
}