import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final String id;
  final String productId;
  final String image;
  final String name;
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final double discountPercentage;
  final DateTime startDate;
  final DateTime endDate;

  OfferEntity copyWith({
    String? id,
    String? productId,
    String? image,
    String? name,
    double? priceBeforeDiscount,
    double? priceAfterDiscount,
    double? discountPercentage,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return OfferEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      name: name ?? this.name,
      priceBeforeDiscount: priceBeforeDiscount ?? this.priceBeforeDiscount,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  OfferEntity({
   required this.id,
    required this.productId,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.name,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
  });

  /// هل العرض شغال حاليًا؟
  // bool get isActive {
  //   final now = DateTime.now();
  //
  //   return !startDate.isAfter(now) &&
  //       !endDate.isBefore(now);
  // }
  bool get isActive {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day + 1);

    return !today.isBefore(start) && today.isBefore(end);
  }
  /// هل العرض انتهى؟
  bool get isExpired {
    final today = DateTime.now();
    final current = DateTime(today.year, today.month, today.day);

    final end = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );

    return current.isAfter(end);
  }
  /// هل العرض لسه ما بدأش؟
  bool get isUpcoming {
    return DateTime.now().isBefore(startDate);
  }

  /// عدد الأيام المتبقية
  int get remainingDays {
    return endDate.difference(DateTime.now()).inDays;
  }

  /// قيمة الخصم الفعلية
  double get discountAmount {
    return priceBeforeDiscount - priceAfterDiscount;
  }

  /// نسبة الخصم محسوبة من الأسعار
  double get calculatedDiscountPercentage {
    if (priceBeforeDiscount == 0) return 0;
    return ((priceBeforeDiscount - priceAfterDiscount) / priceBeforeDiscount) *
        100;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>[
    id,
    productId,
    discountPercentage,
    startDate,
    endDate,
  ];
}
