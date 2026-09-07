import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/selected_location_entity.dart';

class SelectedLocationModel {
  final String id;
  final String title;
  final String subTitle;
  final double cost;
  final DateTime createdAt;

  const SelectedLocationModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.cost,
    required this.createdAt,
  });

  factory SelectedLocationModel.fromJson(Map<String, dynamic> json,) {
    return SelectedLocationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTitle: json['subTitle'] ?? '',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory SelectedLocationModel.fromEntity(SelectedLocationEntity entity,) {
    return SelectedLocationModel(
      id: entity.id,
      title: entity.title,
      subTitle: entity.subTitle,
      cost: entity.cost,
      createdAt: entity.createdAt,
    );
  }

  SelectedLocationEntity toEntity() {
    return SelectedLocationEntity(
      id: id,
      title: title,
      subTitle: subTitle,
      cost: cost,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'cost': cost,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
