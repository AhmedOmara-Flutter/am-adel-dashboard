
class OrderReviewEntity {
  final String? id;
  final String orderId;
  final String userId;
  final String? customerName;
  final String? customerPhone;
  final int foodRating;
  final String foodReview;
  final int driverRating;
  final String driverReview;
  final DateTime createdAt;

  const OrderReviewEntity({
    this.id,
    required this.orderId,
    required this.userId,
    this.customerName,
    this.customerPhone,
    required this.foodRating,
    required this.foodReview,
    required this.driverRating,
    required this.driverReview,
    required this.createdAt,
  });
}
