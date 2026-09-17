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
        if (isLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) =>
                SkeletonizerOrderItem(),
          );
        }

        if (recentOrders.isEmpty) {
          return Container(margin: EdgeInsets.only(bottom: 20),
              child: Text('لا يوجد حاليا طلبات حديثه', style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentOrders.length,
          itemBuilder: (context, index) {
            final order = recentOrders[index];
            return GestureDetector(
              onTap: (){
                context.read<MainCubit>().changeIndex(5);
              },
              child: OrderItem(
                amount: order.cartEntity.getTotalPrice(),
                status: order.status.ar,
                statusColor: order.status.color,
                customerName: makeFullName(order.userEntity!.userName),
                time: getTimeOnly(order.createdAt.toString()),
                products: order.cartEntity.cartItems
                    .map((item) =>
                '${item.product.name} × ${item.quantity}')
                    .join('\n'),
                deliveryCost: order.selectedLocationEntity!.cost,
              ),
            );
          },
        );
      },
    );
  }
}
