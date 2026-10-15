import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/custom_container.dart';
import 'best_seller_list_view_mobile.dart';

class BestSellerCardMobile extends StatelessWidget {
  const BestSellerCardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(13),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColor.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'أفضل المنتجات',
                          style: StyleManager.font16Weight700(
                            context,
                          ).copyWith(color: AppColor.textPrimary),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'الأكثر مبيعًا هذا الشهر',
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(color: AppColor.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFFE0B2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE07800),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'TOP 5',
                      style: StyleManager.font11Weight400(context).copyWith(
                        color: const Color(0xFFB85C00),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const BestSellerListViewMobile(),
        ],
      ),
    );
  }
}