class DailyReportEntity {
   String? id;
  final DateTime date;
  final int ordersCount;
  final double subtotal;
  final double deliveryCost;
  final double total;
  final double cashTotal;
  final double onlineTotal;
  final DateTime createdAt;

   DailyReportEntity({
    this.id,
    required this.date,
    required this.ordersCount,
    required this.subtotal,
    required this.deliveryCost,
    required this.total,
    required this.cashTotal,
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
    double? cashTotal,
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
      cashTotal: cashTotal ?? this.cashTotal,
      onlineTotal: onlineTotal ?? this.onlineTotal,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}