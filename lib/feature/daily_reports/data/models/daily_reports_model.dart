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
    required super.cashSubtotal,
    required super.cashDelivery,
    required super.cashTotal,
    required super.onlineSubtotal,
    required super.onlineDelivery,
    required super.onlineTotal,
    required super.createdAt,
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

      cashSubtotal:
      (json['cashSubtotal'] as num?)?.toDouble() ?? 0.0,
      cashDelivery:
      (json['cashDelivery'] as num?)?.toDouble() ?? 0.0,
      cashTotal:
      (json['cashTotal'] as num?)?.toDouble() ?? 0.0,

      onlineSubtotal:
      (json['onlineSubtotal'] as num?)?.toDouble() ?? 0.0,
      onlineDelivery:
      (json['onlineDelivery'] as num?)?.toDouble() ?? 0.0,
      onlineTotal:
      (json['onlineTotal'] as num?)?.toDouble() ?? 0.0,

      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(date),
      'ordersCount': ordersCount,
      'subtotal': subtotal,
      'deliveryCost': deliveryCost,
      'total': total,

      'cashSubtotal': cashSubtotal,
      'cashDelivery': cashDelivery,
      'cashTotal': cashTotal,

      'onlineSubtotal': onlineSubtotal,
      'onlineDelivery': onlineDelivery,
      'onlineTotal': onlineTotal,

      'createdAt': Timestamp.fromDate(createdAt),
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

      cashSubtotal: entity.cashSubtotal,
      cashDelivery: entity.cashDelivery,
      cashTotal: entity.cashTotal,

      onlineSubtotal: entity.onlineSubtotal,
      onlineDelivery: entity.onlineDelivery,
      onlineTotal: entity.onlineTotal,

      createdAt: entity.createdAt,
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

      cashSubtotal: cashSubtotal,
      cashDelivery: cashDelivery,
      cashTotal: cashTotal,

      onlineSubtotal: onlineSubtotal,
      onlineDelivery: onlineDelivery,
      onlineTotal: onlineTotal,

      createdAt: createdAt,
    );
  }
}