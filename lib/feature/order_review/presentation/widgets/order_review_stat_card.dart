
import 'package:am_adel_dashboard/core/utils/app_imports.dart';

import '../../../../core/widgets/custom_container.dart';

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
    return CustomContainer(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                  SizedBox(width: 10,),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font12Weight500(context),
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
                      style: StyleManager.font19Weight700(context),
                    ),
                  ),
                  if (showStar) ...[
                    const SizedBox(width: 7),
                    const Icon(
                      Icons.star_rounded,
                      color: AppColor.accentColor,
                      size: 18,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 3,
                width: 55,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 5),

            ],
          ),
        ],
      ),
    );
  }
}
