import 'package:am_adel_dashboard/core/cubit/orders_cubit/orders_cubit.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/order_item_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/skeletonizer_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/order_enum.dart';

class RecentOrdersListDesktop extends StatelessWidget {
  const RecentOrdersListDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.watch<OrdersCubit>();
        final recentOrders = cubit.recentOrders;

        final isLoading =
        state is GetOrdersLoadingState;

        if (isLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.all(14),
                child: SkeletonizerOrderItem(),
              );
            },
          );
        }

        if (recentOrders.isEmpty) {
          return Padding(
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
                    color: AppColor.textSecondary.withOpacity(.65),
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
                    color: AppColor.textSecondary.withOpacity(.70),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentOrders.take(3).length + 1,
          separatorBuilder: (context, index) {
            return Container(
              height: 1,
              color: AppColor.divider.withOpacity(.45),
            );
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
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
                      flex: 4,
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
              );
            }

            final order = recentOrders[index - 1];

            final deliveryCost =
                order.selectedLocationEntity?.cost ?? 0;

            final totalPrice =
                order.cartEntity.getTotalPrice() -
                    order.couponDiscount +
                    deliveryCost;

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
              deliveryCost: deliveryCost,
            );
          },
        );
      },
    );
  }
}