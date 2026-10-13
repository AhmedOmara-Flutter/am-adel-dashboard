import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import '../../../../core/extension/responsive_extension.dart';
import '../../data/models/order_review_model.dart';
import 'order_review_statistics_mobile.dart';
import 'order_review_statistics_desktop.dart';

class OrderReviewStatistics extends StatelessWidget {
  const OrderReviewStatistics({super.key, required this.reviews});

  final List<OrderReviewModel> reviews;

  double get foodAverage => reviews.isEmpty
      ? 0
      : reviews.fold<int>(0, (sum, r) => sum + r.foodRating) / reviews.length;

  double get driverAverage => reviews.isEmpty
      ? 0
      : reviews.fold<int>(0, (sum, r) => sum + r.driverRating) / reviews.length;

  int get excellentReviews =>
      reviews.where((r) => r.foodRating >= 4 && r.driverRating >= 4).length;

  @override
  Widget build(BuildContext context) {
    final total = reviews.length;
    final food = foodAverage.toStringAsFixed(1);
    final driver = driverAverage.toStringAsFixed(1);
    final excellent = excellentReviews;

    return context.isDesktop
        ? OrderReviewStatisticsDesktop(
            total: total,
            food: food,
            driver: driver,
            excellent: excellent,
          )
        : OrderReviewStatisticsMobile(
            total: total,
            food: food,
            driver: driver,
            excellent: excellent,
          );
  }
}
