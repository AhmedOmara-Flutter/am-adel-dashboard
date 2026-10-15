import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/custom_container.dart';
import '../../../../../core/widgets/custom_gradient_icon.dart';
import '../../../../../core/widgets/icon_badge.dart';
import 'recent_orders_list_desktop.dart';

class RecentOrderCardDesktop extends StatelessWidget {
  const RecentOrderCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              IconBadge(
                icon: Icons.access_time,
                iconColor: AppColor.mainColor,
              ),
              const SizedBox(width: 8),
              Text(
                'الطلبات الحديثة',
                style: StyleManager.font13Weight400(context).copyWith(
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
                    ).copyWith(color: AppColor.mainColor),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: RecentOrdersListDesktop()),
        ],
      ),
    );
  }
}
