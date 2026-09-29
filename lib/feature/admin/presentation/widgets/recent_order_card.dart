import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/recent_orders_list_view.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/widgets/icon_badge.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersCubit = context.watch<OrdersCubit>();
    final int ordersCount = ordersCubit.allOrders.length;
    final bool hasOrders = ordersCount > 0;

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
            color: AppColor.mainColor.withOpacity(.06),
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
            children: [
              IconBadge(
                icon: Icons.receipt_long_rounded,
                iconColor: AppColor.mainColor,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الطلبات الحديثة',
                      style: StyleManager.font12Weight500(context).copyWith(
                        color: AppColor.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          hasOrders
                              ? '$ordersCount طلب في المتجر'
                              : 'لا توجد طلبات حاليًا',
                          style: StyleManager.font12Weight500(context).copyWith(
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

              if (hasOrders)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(11),
                    onTap: () {
                      context.read<MainCubit>().changeIndex(5);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'عرض الكل',
                            style: StyleManager.font12Weight500(context).copyWith(
                              color: AppColor.mainColor,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 10,
                            color: AppColor.mainColor,
                          ),
                        ],
                      ),
                    ),
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

          const RecentOrdersListView(),
        ],
      ),
    );
  }
}