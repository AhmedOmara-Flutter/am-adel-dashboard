import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/app_skeleton_effect.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../orders/presentation/widgets/order_status_badge.dart';

class SkeletonizerOrderItemMobile extends StatelessWidget {
  const SkeletonizerOrderItemMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect:AppSkeletonEffect.shimmer,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColor.divider.withOpacity(.3)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.backgroundDark.withOpacity(.15),
                        border: Border.all(
                          color: AppColor.divider.withOpacity(.4),
                        ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'customerName',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font14Weight600(
                              context,
                            ).copyWith(color: AppColor.textPrimary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'products',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font12Weight500(
                              context,
                            ).copyWith(color: AppColor.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColor.divider.withOpacity(.25),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.schedule_outlined,
                            size: 13,
                            color: AppColor.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              'bhjnmjbn hj,',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font11Weight400(
                                context,
                              ).copyWith(color: AppColor.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_shipping_outlined,
                            size: 13,
                            color: AppColor.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '{deliveryCost.} ج.م',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font11Weight400(
                                context,
                              ).copyWith(color: AppColor.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '{amount.} ج.م',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: StyleManager.font14Weight600(
                          context,
                        ).copyWith(color: AppColor.mainColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
