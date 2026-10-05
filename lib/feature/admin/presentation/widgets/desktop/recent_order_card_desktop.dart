import 'package:am_adel_dashboard/core/cubit/orders_cubit/orders_cubit.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/order_item_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/skeletonizer_order_item.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/order_enum.dart';

class RecentOrderCardDesktop extends StatelessWidget {
  const RecentOrderCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColor.border.withOpacity(.32),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          final cubit = context.watch<OrdersCubit>();
          final recentOrders = cubit.recentOrders;
          final isLoading = state is GetOrdersLoadingState;

          if (isLoading) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.07),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: AppColor.border.withOpacity(.20),
                          ),
                        ),
                        child: const Icon(
                          Icons.access_time_rounded,
                          size: 17,
                          color: AppColor.mainColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الطلبات الحديثة',
                            style: StyleManager.font15Weight700(
                              context,
                            ).copyWith(
                              color: AppColor.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'آخر الطلبات الواردة',
                            style: StyleManager.font11Weight400(
                              context,
                            ).copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          hoverColor:
                          AppColor.mainColor.withOpacity(.04),
                          splashColor:
                          AppColor.mainColor.withOpacity(.06),
                          onTap: () {
                            context
                                .read<MainCubit>()
                                .changeIndex(5);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'عرض الكل',
                                  style: StyleManager.font11Weight400(
                                    context,
                                  ).copyWith(
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 13,
                                  color: AppColor.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 1,
                  color: AppColor.divider.withOpacity(.65),
                ),

                const Padding(
                  padding: EdgeInsets.all(14),
                  child: SkeletonizerOrderItem(),
                ),
              ],
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withOpacity(.07),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: AppColor.border.withOpacity(.20)),
                      ),
                      child: const Icon(
                        Icons.access_time_rounded,
                        size: 17,
                        color: AppColor.mainColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'الطلبات الحديثة',
                      style: StyleManager.font13Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    InkWell(
                      onTap: () {
                        context.read<MainCubit>().changeIndex(5);
                      },
                      child: Text(
                        'عرض الكل',
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),                  ],
                ),
              ),
              Container(
                height: 1,
                color: AppColor.divider.withOpacity(.65),
              ),

              if (recentOrders.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 35,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.mainColor.withOpacity(.06),
                          border: Border.all(
                            color: AppColor.border.withOpacity(.25),
                          ),
                        ),
                        child: Icon(
                          Icons.receipt_long_outlined,
                          size: 25,
                          color:
                          AppColor.textSecondary.withOpacity(.65),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'لا يوجد حاليًا طلبات حديثة',
                        style: StyleManager.font12Weight500(
                          context,
                        ).copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'ستظهر الطلبات الجديدة هنا',
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                          color:
                          AppColor.textSecondary.withOpacity(.70),
                        ),
                      ),
                    ],
                  ),
                ),

              if (recentOrders.isNotEmpty)
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(.035),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColor.border.withOpacity(.20),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'العميل والمنتجات',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Text(
                          'الوقت',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Text(
                          'التوصيل',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Text(
                          'الحالة',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Text(
                          'الإجمالي',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(width: 24),
                    ],
                  ),
                ),

              if (recentOrders.isNotEmpty)
                ...recentOrders.map(
                      (order) {
                    final totalPrice =
                        order.cartEntity.getTotalPrice() -
                            order.couponDiscount +
                            (order.selectedLocationEntity?.cost ?? 0);

                    return OrderItemDesktop(
                      amount: totalPrice,
                      status: order.status.ar,
                      statusColor: order.status.color,
                      customerName: makeFullName(
                        order.userEntity!.userName,
                      ),
                      time: getTimeOnly(
                        order.createdAt.toString(),
                      ),
                      products: order.cartEntity.cartItems
                          .map(
                            (item) =>
                        '${item.product.name} × ${item.quantity}',
                      )
                          .join('\n'),
                      deliveryCost:
                      order.selectedLocationEntity?.cost ?? 0,
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}