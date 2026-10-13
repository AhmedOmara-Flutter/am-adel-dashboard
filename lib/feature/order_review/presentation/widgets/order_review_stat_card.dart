
import 'package:am_adel_dashboard/core/utils/app_imports.dart';

class OrderReviewStatCard extends StatelessWidget {
  const OrderReviewStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.showStar = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.border.withOpacity(.32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -22,
            top: -25,
            child: Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font12Weight500(context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 23,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font23Weight700(context),
                      ),
                    ),
                    if (showStar) ...[
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.star_rounded,
                        color: AppColor.accentColor,
                        size: 20,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 4,
                  width: 55,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
