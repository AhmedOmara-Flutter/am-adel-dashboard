import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';

import 'package:am_adel_dashboard/feature/admin/presentation/widgets/recent_orders_list_view.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final hasOrders =
        context.watch<OrdersCubit>().allOrders.isNotEmpty;

    return Container(
      margin: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        // Light Cream
        color: AppColor.cardLight,

        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),

        border: Border.all(
          color: AppColor.border.withOpacity(.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.07),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,

      child: Column(
        children: [

          // ==========================================
          // Header
          // ==========================================

          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 15,
              right: 15,
            ),

            child: Row(
              children: [

                // Icon Container
                Container(
                  width: 42,
                  height: 42,

                  decoration: BoxDecoration(
                    color: AppColor.accentColor.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.receipt_long_rounded,
                    color: AppColor.accentColor,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  'الطلبات الحديثة',

                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ==========================================
          // Orders
          // ==========================================

          const RecentOrdersListView(),

          // ==========================================
          // View All Orders
          // ==========================================

          if (hasOrders)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                15,
                10,
                15,
                15,
              ),

              child: Material(
                color: Colors.transparent,

                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),

                  onTap: () {
                    context
                        .read<MainCubit>()
                        .changeIndex(5);
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 18,
                    ),

                    decoration: BoxDecoration(
                      color: AppColor.mainColor.withOpacity(.06),

                      border: Border.all(
                        color: AppColor.accentColor.withOpacity(.45),
                      ),

                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),

                    child: Row(
                      children: [

                        // Left Icon
                        const Icon(
                          Icons.grid_view_rounded,
                          size: 18,
                          color: AppColor.mainColor,
                        ),

                        const SizedBox(width: 10),

                        // Text
                        Expanded(
                          child: Text(
                            'عرض جميع الطلبات',

                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // Arrow
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: AppColor.accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
