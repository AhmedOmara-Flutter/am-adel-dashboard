import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/recent_orders_list_view.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';
import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/utils/app_constants.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 10
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(AppConstants.borderColor),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: AppColor.border),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 12,
              left: 15,
              right: 15,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  color: AppColor.mainColor,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'الطلبات الحديثه',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          const RecentOrdersListView(),
          if (context.watch<OrdersCubit>().allOrders.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    context.read<MainCubit>().changeIndex(5);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.border,
                      ),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          size: 16,
                          color: AppColor.textPrimary,
                        ),
                        Text(
                          'عرض جميع الطلبات',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: AppColor.textPrimary,
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
