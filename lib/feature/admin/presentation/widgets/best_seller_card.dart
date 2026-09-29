import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/icon_badge.dart';
import 'best_seller_list_view.dart';

class BestSellerCard extends StatelessWidget {
  const BestSellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
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
          Column(
            children: [
              Row(
                children: [
                  IconBadge(
                    icon: Icons.local_fire_department_rounded,
                    iconColor: AppColor.orange,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'أفضل المنتجات',
                          style: StyleManager.font12Weight500(context)
                              .copyWith(
                            color: AppColor.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColor.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'الأكثر مبيعًا هذا الشهر',
                              style: StyleManager.font12Weight500(context)
                                  .copyWith(
                                color: AppColor.textSecondary,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.border.withOpacity(.45),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          size: 15,
                          color: AppColor.orange,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'TOP 5',
                          style: StyleManager.font12Weight500(context)
                              .copyWith(
                            color: AppColor.orange,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Divider(
                height: 1,
                thickness: .7,
                color: AppColor.border.withOpacity(.35),
              ),

              const SizedBox(height: 12),
            ],
          ),

          const BestSellerListView(),
        ],
      ),
    );
  }
}