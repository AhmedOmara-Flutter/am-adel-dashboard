import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/widgets/empty_widget.dart';
import 'package:am_adel_dashboard/feature/orders/presentation/widgets/build_order_card.dart';
import 'package:am_adel_dashboard/feature/orders/presentation/widgets/skeletonizer_build_order_card.dart';
import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_constants.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  String selectedStatus = 'انتظار';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: AppColor.cardLight,
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                  border: Border.all(
                    color: AppColor.divider.withOpacity(0.5),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    _buildTab('انتظار'),
                    _buildTab('مؤكد'),
                    _buildTab('منتهي'),
                    _buildTab('مسدد'),
                    _buildTab('ملغي'),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              final cubit = context.watch<OrdersCubit>();
              final orders = cubit.filteredOrders;

              if (state is GetOrdersLoadingState) {
                return SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const SkeletonizerBuildOrderCard();
                  },
                );
              }

              if (state is GetOrdersErrorState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(
                        color: AppColor.red,
                      ),
                    ),
                  ),
                );
              }

              if (orders.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyWidget(),
                );
              }

              return SliverList.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return BuildOrderCard(
                    key: ValueKey(orders[index].id),
                    totalOrders: orders.length,
                    index: index,
                    order: orders[index],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title) {
    final isSelected = selectedStatus == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedStatus = title;
          });

          final cubit = context.read<OrdersCubit>();

          switch (title) {
            case 'انتظار':
              cubit.filterByStatus(OrderStatus.pending);
              break;
            case 'مؤكد':
              cubit.filterByStatus(OrderStatus.confirmed);
              break;
            case 'منتهي':
              cubit.filterByStatus(OrderStatus.delivered);
              break;
            case 'مسدد':
              cubit.filterByStatus(OrderStatus.paid);
              break;
            case 'ملغي':
              cubit.filterByStatus(OrderStatus.cancelled);
              break;
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.backgroundDark
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? AppColor.accentColor
                  : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: isSelected
                    ? AppColor.mainColor
                    : AppColor.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}