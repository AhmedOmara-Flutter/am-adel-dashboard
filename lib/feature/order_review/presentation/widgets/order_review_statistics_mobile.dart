
import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'order_review_stat_card.dart';

class OrderReviewStatisticsMobile extends StatelessWidget {
  const OrderReviewStatisticsMobile({
    super.key,
    required this.total,
    required this.food,
    required this.driver,
    required this.excellent,
  });

  final int total;
  final String food;
  final String driver;
  final int excellent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OrderReviewStatCard(
                title: 'إجمالي التقييمات',
                value: '$total',
                icon: Icons.rate_review_rounded,
                color: AppColor.secondaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OrderReviewStatCard(
                title: 'متوسط تقييم الأكل',
                value: food,
                icon: Icons.restaurant_rounded,
                color: AppColor.accentColor,
                showStar: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OrderReviewStatCard(
                title: 'متوسط تقييم المندوب',
                value: driver,
                icon: Icons.delivery_dining_rounded,
                color: AppColor.green,
                showStar: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OrderReviewStatCard(
                title: 'تقييمات ممتازة',
                value: '$excellent',
                icon: Icons.workspace_premium_rounded,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
