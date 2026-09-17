import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

import '../../../../core/enums/order_enum.dart';

class OrderHeaderSection extends StatelessWidget {
  const OrderHeaderSection({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.divider,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColor.backgroundDark,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: AppColor.mainColor,
                  size: 20,
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تفاصيل الطلب',
                      style: StyleManager.font13Weight600(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: order.status.color.withOpacity(.10),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: order.status.color.withOpacity(.25),
                  ),
                ),
                child: Text(
                  order.status.ar,
                  style: StyleManager.font13Weight700(context).copyWith(
                    color: order.status.color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: AppColor.textSecondary,
                ),

                SizedBox(width: 4),

                Text(
                  getDateFormate(order.createdAt.toString()),
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}