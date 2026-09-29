class DailyReportEntity {
  String? id;

  final DateTime date;
  final int ordersCount;

  final double subtotal;
  final double deliveryCost;
  final double total;

  final double cashSubtotal;
  final double cashDelivery;
  final double cashTotal;

  final double onlineSubtotal;
  final double onlineDelivery;
  final double onlineTotal;

  final DateTime createdAt;

  DailyReportEntity({
    this.id,
    required this.date,
    required this.ordersCount,
    required this.subtotal,
    required this.deliveryCost,
    required this.total,
    required this.cashSubtotal,
    required this.cashDelivery,
    required this.cashTotal,
    required this.onlineSubtotal,
    required this.onlineDelivery,
    required this.onlineTotal,
    required this.createdAt,
  });

  DailyReportEntity copyWith({
    String? id,
    DateTime? date,
    int? ordersCount,
    double? subtotal,
    double? deliveryCost,
    double? total,
    double? cashSubtotal,
    double? cashDelivery,
    double? cashTotal,
    double? onlineSubtotal,
    double? onlineDelivery,
    double? onlineTotal,
    DateTime? createdAt,
  }) {
    return DailyReportEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      ordersCount: ordersCount ?? this.ordersCount,
      subtotal: subtotal ?? this.subtotal,
      deliveryCost: deliveryCost ?? this.deliveryCost,
      total: total ?? this.total,

      cashSubtotal: cashSubtotal ?? this.cashSubtotal,
      cashDelivery: cashDelivery ?? this.cashDelivery,
      cashTotal: cashTotal ?? this.cashTotal,

      onlineSubtotal: onlineSubtotal ?? this.onlineSubtotal,
      onlineDelivery: onlineDelivery ?? this.onlineDelivery,
      onlineTotal: onlineTotal ?? this.onlineTotal,

      createdAt: createdAt ?? this.createdAt,
    );
  }
}