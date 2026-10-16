import 'package:am_adel_dashboard/core/cubit/orders_cubit/orders_cubit.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/order_item_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/skeletonizer_order_item_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/order_enum.dart';

class RecentOrdersListDesktop extends StatelessWidget {
  const RecentOrdersListDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final recentOrders = context.read<OrdersCubit>().recentOrders;

        final isLoading = state is GetOrdersLoadingState;

        if (isLoading)
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: 4,
            itemBuilder: (context, index) {
              return SkeletonizerOrderItemDesktop();

            },
          );

        if (recentOrders.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    textAlign: TextAlign.center,
                    style: StyleManager.font12Weight500(
                      context,
                    ).copyWith(color: AppColor.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ستظهر الطلبات الجديدة هنا',
                    textAlign: TextAlign.center,
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(color: AppColor.textSecondary.withOpacity(.70)),
                  ),
                ],
              ),
            ),
          );
        }

        final visibleOrders = recentOrders.take(6).toList();

        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: visibleOrders.length + 1,
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
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.035),
                  border: Border(
                    bottom: BorderSide(color: AppColor.border.withOpacity(.20)),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: AppColor.divider.withOpacity(.65),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              ).copyWith(color: AppColor.textSecondary),
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
                              ).copyWith(color: AppColor.textSecondary),
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
                              ).copyWith(color: AppColor.textSecondary),
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
                              ).copyWith(color: AppColor.textSecondary),
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
                              ).copyWith(color: AppColor.textSecondary),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            final order = visibleOrders[index - 1];

            final deliveryCost = order.selectedLocationEntity?.cost ?? 0;

            final totalPrice =
                order.cartEntity.getTotalPrice() -
                order.couponDiscount +
                deliveryCost;

            return OrderItemDesktop(
              amount: totalPrice,
              status: order.status.ar,
              statusColor: order.status.color,
              customerName: makeFullName(order.userEntity!.userName),
              time: getTimeOnly(order.createdAt.toString()),
              products: order.cartEntity.cartItems
                  .map((item) => '${item.product.name} × ${item.quantity}')
                  .join('\n'),
              deliveryCost: deliveryCost,
            );
          },
        );
      },
    );
  }
}
