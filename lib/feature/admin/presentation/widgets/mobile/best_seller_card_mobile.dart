import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import '../../../../../core/utils/app_imports.dart';
import 'best_seller_list_view_mobile.dart';

class BestSellerCardMobile extends StatelessWidget {
  const BestSellerCardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
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
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.orange.withOpacity(.10),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColor.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'TOP 5',
                            style: StyleManager.font11Weight400(
                              context,
                            ).copyWith(color: AppColor.orange),
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
