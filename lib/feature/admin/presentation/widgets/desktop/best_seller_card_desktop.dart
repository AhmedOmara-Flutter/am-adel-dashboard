import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/custom_gradient_icon.dart';
import '../../../../../core/widgets/icon_badge.dart';
import 'best_seller_list_view_desktop.dart';

class BestSellerCardDesktop extends StatelessWidget {
  const BestSellerCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.divider.withOpacity(0.25),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconBadge(
                  icon: Icons.local_fire_department_outlined,
                  iconColor: AppColor.mainColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'افضل المنتجات',
                  style: StyleManager.font13Weight400(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: const BestSellerListViewDesktop()),
        ],
      ),
    );
  }
}
