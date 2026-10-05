import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/mobile/recent_orders_list_view_mobile.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/orders_cubit/orders_cubit.dart';

class RecentOrderCardMobile extends StatelessWidget {
  const RecentOrderCardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersCubit = context.watch<OrdersCubit>();
    final int ordersCount = ordersCubit.allOrders.length;
    final bool hasOrders = ordersCount > 0;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.40)),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'الطلبات الحديثة',
                          style: StyleManager.font16Weight700(
                            context,
                          ).copyWith(color: AppColor.textPrimary),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          hasOrders
                              ? 'متابعة أحدث الطلبات'
                              : 'لا توجد طلبات حاليًا',
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(color: AppColor.textSecondary),
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
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      context.read<MainCubit>().changeIndex(5);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'عرض الكل',
                            style: StyleManager.font12Weight500(
                              context,
                            ).copyWith(color: AppColor.mainColor),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_back_rounded,
                            size: 16,
                            color: AppColor.mainColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          const RecentOrdersListViewMobile(),
        ],
      ),
    );
  }
}
