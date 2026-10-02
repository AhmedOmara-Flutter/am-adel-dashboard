import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/enums/order_enum.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/skeletonizer_order_item.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../main/presentation/view_model/main_cubit.dart';
import 'order_item.dart';

class RecentOrdersListView extends StatelessWidget {
  const RecentOrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.watch<OrdersCubit>();
        final recentOrders = cubit.recentOrders;
        final isLoading = state is GetOrdersLoadingState;
        if (isLoading)
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) => SkeletonizerOrderItem(),
          );

        if (recentOrders.isEmpty) {
          return Container(
            margin: EdgeInsets.only(bottom: 20, top: 15),
            child: Text(
              'لا يوجد حاليا طلبات حديثه',
              style: StyleManager.font15Weight800(context).copyWith(
                  fontSize: 13
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: recentOrders.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final order = recentOrders[index];
            final totalPrice =
                order.cartEntity.getTotalPrice() -
                order.couponDiscount +
                (order.selectedLocationEntity?.cost ?? 0);

            return GestureDetector(
              onTap: () {
                context.read<MainCubit>().changeIndex(5);
              },
              child: OrderItem(
                amount: totalPrice,
                status: order.status.ar,
                statusColor: order.status.color,
                customerName: makeFullName(order.userEntity!.userName),
                time: getTimeOnly(order.createdAt.toString()),
                products: order.cartEntity.cartItems
                    .map((item) => '${item.product.name} × ${item.quantity}')
                    .join('\n'),
                deliveryCost: order.selectedLocationEntity?.cost ?? 0,
              ),
            );
          },
        );
      },
    );
  }
}
