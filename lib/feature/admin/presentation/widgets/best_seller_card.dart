import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/config_size.dart';
import 'best_seller_list_view.dart';

class BestSellerCard extends StatelessWidget {
  const BestSellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.sizeOf(context).width > ConfigSize.phone;

    return Container(
      margin: EdgeInsets.only(
        top: isDesktop ? 10 : 0,
        bottom: 10,
        left: 10,
        right: isDesktop ? 0 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.40), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentColor.withOpacity(.07),
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.accentColor.withOpacity(.18),
                        AppColor.accentColor.withOpacity(.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColor.accentColor.withOpacity(.12),
                    ),
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: AppColor.accentColor,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 12),

                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أفضل المنتجات',
                        style:StyleManager.font12Weight500(context)
                            .copyWith(
                              color: AppColor.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'الأكثر مبيعًا وطلبًا',
                        style: StyleManager.font12Weight500(context).copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.accentColor.withOpacity(.09),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColor.accentColor.withOpacity(.12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColor.accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'الأكثر طلبًا',
                        style: StyleManager.font12Weight500(context).copyWith(
                          color: AppColor.accentColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColor.divider.withOpacity(.45),
          ),

          const SizedBox(height: 8),

          // =====================================================
          // BEST SELLER LIST
          // =====================================================
          const BestSellerListView(),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
