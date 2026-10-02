import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'customer_stat.dart';

class SkeletonizerCustomerCard extends StatelessWidget {
  const SkeletonizerCustomerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(
            AppConstants.borderRadius + 4,
          ),
          border: Border.all(
            color: AppColor.divider.withOpacity(.45),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.mainColor.withOpacity(.25),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 27,
                    backgroundColor: AppColor.backgroundDark,
                    backgroundImage: AssetImage(
                      Assets.assets.images.customer.path,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        makeFullName('user.userName'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font13Weight600(
                          context,
                        ).copyWith(
                          color: AppColor.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'user.email',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font12Weight500(
                          context,
                        ).copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
      
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 14,
                              color: AppColor.mainColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'user.phone',
                              style: StyleManager.font12Weight500(
                                context,
                              ).copyWith(
                                color: AppColor.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              height: 1,
              color: AppColor.divider.withOpacity(.35),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomerStat(
                    icon: Icons.shopping_bag_outlined,
                    value: '10',
                    label: 'الطلبات',
                  ),
                ),
                Container(
                  height: 32,
                  width: 1,
                  color: AppColor.divider.withOpacity(.4),
                ),
                Expanded(
                  child: CustomerStat(
                    icon: Icons.payments_outlined,
                    value: '4',
                    label: 'إجمالي الشراء',
                  ),
                ),
                Container(
                  height: 32,
                  width: 1,
                  color: AppColor.divider.withOpacity(.4),
                ),
                Expanded(
                  child: CustomerStat(
                    icon: Icons.calendar_today_outlined,
                    value:'merk',
                    label: 'تاريخ التسجيل',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

