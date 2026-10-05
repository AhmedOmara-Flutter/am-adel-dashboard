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
            padding: const EdgeInsets.all(14),
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
                    Icons.access_time_rounded,
                    size: 17,
                    color: AppColor.mainColor,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'افضل المنتجات',
                      style: StyleManager.font15Weight700(
                        context,
                      ).copyWith(color: AppColor.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'الأكثر مبيعا هذا الشهر',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(color: AppColor.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 1, color: AppColor.divider.withOpacity(.65)),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal:14,
            ),
            child: const BestSellerListViewDesktop(),
          ),
        ],
      ),
    );
  }
}
