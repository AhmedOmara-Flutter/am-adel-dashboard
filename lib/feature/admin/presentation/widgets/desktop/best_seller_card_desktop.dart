import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import '../../../../../core/utils/app_imports.dart';
import 'best_seller_list_view_desktop.dart';
import '../mobile/best_seller_list_view_mobile.dart';

class BestSellerCardDesktop extends StatelessWidget {
  const BestSellerCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.40)),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentColor.withOpacity(.06),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(.07),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: AppColor.border.withOpacity(.20),
                    ),
                  ),
                  child: const Icon(
                    Icons.local_fire_department_outlined,
                    size: 17,
                    color: AppColor.mainColor,
                  ),
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
          Container(
            height: 1,
            color: AppColor.divider.withOpacity(.65),
          ),
          const SizedBox(height: 20),
          const BestSellerListViewDesktop(),
        ],
      ),
    );
  }
}
