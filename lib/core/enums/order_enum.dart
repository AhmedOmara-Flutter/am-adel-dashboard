import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  confirmed,
  delivered,
  cancelled,
}

extension OrderStatusUI on OrderStatus {
  String get ar {
    switch (this) {
      case OrderStatus.pending:
        return 'قيد الانتظار';

      case OrderStatus.confirmed:
        return 'تم التأكيد';

      case OrderStatus.delivered:
        return 'تم الانتهاء';

      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;

      case OrderStatus.confirmed:
        return Colors.blue;

      case OrderStatus.delivered:
        return Colors.green;

      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}