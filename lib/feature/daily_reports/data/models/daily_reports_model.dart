import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/daily_reports_entity.dart';

class DailyReportModel extends DailyReportEntity {
   DailyReportModel({
    super.id,
    required super.date,
    required super.ordersCount,
    required super.subtotal,
    required super.deliveryCost,
    required super.total,
    required super.createdAt,
    required super.cashTotal,
  required super.onlineTotal,

  });

  factory DailyReportModel.fromJson(
      Map<String, dynamic> json, {
        String? id,
      }) {
    return DailyReportModel(
      id: id ?? json['id'] as String?,
      date: (json['date'] as Timestamp).toDate(),
      ordersCount: json['ordersCount'] as int,
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      cashTotal: (json['cashTotal'] as num).toDouble(),
      onlineTotal: (json['onlineTotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(date),
      'ordersCount': ordersCount,
      'subtotal': subtotal,
      'deliveryCost': deliveryCost,
      'total': total,
      'createdAt': Timestamp.fromDate(createdAt),
      'cashTotal': cashTotal,
      'onlineTotal': onlineTotal,
    };
  }

  factory DailyReportModel.fromEntity(
      DailyReportEntity entity,
      ) {
    return DailyReportModel(
      id: entity.id,
      date: entity.date,
      ordersCount: entity.ordersCount,
      subtotal: entity.subtotal,
      deliveryCost: entity.deliveryCost,
      total: entity.total,
      createdAt: entity.createdAt,
      cashTotal: entity.cashTotal,
      onlineTotal: entity.onlineTotal,
    );
  }

  DailyReportEntity toEntity() {
    return DailyReportEntity(
      id: id,
      date: date,
      ordersCount: ordersCount,
      subtotal: subtotal,
      deliveryCost: deliveryCost,
      total: total,
      createdAt: createdAt,
      cashTotal: cashTotal,
      onlineTotal: onlineTotal,
    );
  }
}