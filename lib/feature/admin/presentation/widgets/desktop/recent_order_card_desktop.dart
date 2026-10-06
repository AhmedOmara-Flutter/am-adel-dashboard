import '../../../../../core/utils/app_imports.dart';
import 'recent_orders_list_desktop.dart';

class RecentOrderCardDesktop extends StatelessWidget {
  const RecentOrderCardDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.border.withOpacity(.40),
        ),
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
                    Icons.access_time_rounded,
                    size: 17,
                    color: AppColor.mainColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'الطلبات الحديثة',
                  style: StyleManager.font13Weight400(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    context.read<MainCubit>().changeIndex(5);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Text(
                      'عرض الكل',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColor.divider.withOpacity(.65),
          ),
          const RecentOrdersListDesktop(),
        ],
      ),
    );
  }
}