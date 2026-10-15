import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../orders/presentation/widgets/order_status_badge.dart';

class SkeletonizerOrderItemDesktop extends StatelessWidget {
  const SkeletonizerOrderItemDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect:AppSkeletonEffect.shimmer,
      child:  Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: AppColor.mainColor.withOpacity(.025),
          splashColor: AppColor.mainColor.withOpacity(.035),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.border.withOpacity(.15),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.mainColor.withOpacity(.06),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.assets.images.customer.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'customerName',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font13Weight700(
                                context,
                              ).copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'products'.replaceAll('\n', ' • '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font11Weight400(
                                context,
                              ).copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ================= TIME =================
                Expanded(
                  flex: 2,
                  child: Text(
                    'bjnkmjnkmjnkm',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font12Weight500(
                      context,
                    ).copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ),

                // ================= DELIVERY =================
                Expanded(
                  flex: 2,
                  child: Text( '{delivery(0)} ج.م',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color:AppColor.textSecondary,
                    ),
                  ),
                ),

                // ================= STATUS =================
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'status',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                        ),
                      ),
                    ),
                  ),
                ),

                // ================= TOTAL =================
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '{amount.(2)} ج.م',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font13Weight700(
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
        ),
      ),
    );
  }
}
