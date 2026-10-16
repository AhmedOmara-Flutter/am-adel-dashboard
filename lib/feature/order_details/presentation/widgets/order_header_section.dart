import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/order_enum.dart';
import '../../../../core/widgets/custom_container.dart';

class OrderHeaderSection extends StatelessWidget {
  const OrderHeaderSection({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              color: AppColor.mainColor,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'طلب جديد',
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'تفاصيل الطلب',
                  style: StyleManager.font15Weight700(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColor.textSecondary.withOpacity(.65),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        getDateFormate(
                          order.createdAt.toString(),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: order.status.color.withOpacity(.09),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: order.status.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      order.status.ar,
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(
                        color: order.status.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
