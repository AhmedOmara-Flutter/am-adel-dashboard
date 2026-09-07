import 'package:equatable/equatable.dart';

class RestaurantStatusEntity extends Equatable {
  final bool isOpen;
  final DateTime? updatedAt;

  const RestaurantStatusEntity({
    required this.isOpen,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    isOpen,
    updatedAt,
  ];
}