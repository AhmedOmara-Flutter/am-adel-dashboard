import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/custom_container.dart';
import '../../../../../core/widgets/icon_badge.dart';
import 'best_seller_list_view_desktop.dart';

class BestSellerCardDesktop extends StatelessWidget {
  const BestSellerCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
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
          SizedBox(height: 12,),
          const Expanded(
            child: BestSellerListViewDesktop(),
          ),
        ],
      ),
    );
  }
}
