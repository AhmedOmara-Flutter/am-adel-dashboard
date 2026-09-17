import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/enums/order_enum.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/entities/order_entity.dart';
import '../../../../core/services/print_service.dart';
import '../../../../core/utils/app_constants.dart';
import 'order_customer_info.dart';
import 'order_status_action.dart';
import 'order_status_badge.dart';
import 'order_summary_section.dart';
import 'order_user_image.dart';

class BuildOrderCard extends StatefulWidget {
  final OrderEntity order;
  final int index;
  final int totalOrders;

  const BuildOrderCard({
    super.key,
    required this.order,
    required this.index,
    required this.totalOrders,
  });

  @override
  State<BuildOrderCard> createState() => _BuildOrderCardState();
}

class _BuildOrderCardState extends State<BuildOrderCard> {
  bool _printing = false;

  int get _orderNumber {
    return widget.totalOrders - widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final orderNumberText = _orderNumber.toString().padLeft(2, '0');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteManager.orderDetails,
          arguments: {
            'order': widget.order,
            'orderNumber': _orderNumber,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(
            AppConstants.borderRadius,
          ),
          border: Border.all(
            color: AppColor.divider.withOpacity(0.5)
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderUserImage(
                      order: widget.order,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OrderCustomerInfo(
                        customerName: makeFullName(
                          widget.order.userEntity!.userName,
                        ),
                        phone: widget.order.userEntity!.phone,
                        orderId: orderNumberText,
                        address: widget.order.getFullAddress(),
                        location: widget
                            .order
                            .selectedLocationEntity!
                            .title,
                        products: widget.order.cartEntity.cartItems
                            .map(
                              (item) =>
                          '${item.product.name} × ${item.quantity}',
                        )
                            .join('\n'),
                        price: widget.order.cartEntity.cartItems
                            .map(
                              (item) => '${item.unitPrice} ج.م',
                        )
                            .join('\n'),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),

                const SizedBox(height: 12),

                OrderSummarySection(
                  time: getTimeOnly(
                    widget.order.createdAt.toString(),
                  ),
                  deliveryCost:
                  widget.order.selectedLocationEntity!.cost,
                  totalPrice:
                  widget.order.cartEntity.getTotalPrice(),
                ),

                if (widget.order.status == OrderStatus.pending) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OrderStatusButton(
                          title: 'تأكيد الطلب',
                          icon: Icons.check,
                          color: OrderStatus.confirmed.color,
                          onTap: () async {
                            if (_printing) {
                              return;
                            }

                            _printing = true;

                            final order = widget.order;

                            try {
                              await context
                                  .read<OrdersCubit>()
                                  .updateOrderStatus(
                                orderId: order.id ?? '',
                                status: OrderStatus.confirmed,
                              );
                            } finally {
                              _printing = false;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OrderStatusButton(
                          title: 'إلغاء الطلب',
                          icon: Icons.cancel,
                          color: OrderStatus.cancelled.color,
                          onTap: () {
                            context.read<OrdersCubit>().updateOrderStatus(
                              orderId: widget.order.id ?? '',
                              status: OrderStatus.cancelled,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                if (widget.order.status == OrderStatus.confirmed) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OrderStatusButton(
                          title: 'إنهاء الطلب',
                          icon: Icons.done_all,
                          color: OrderStatus.delivered.color,
                          onTap: () async {
                            await context
                                .read<OrdersCubit>()
                                .updateOrderStatus(
                              orderId: widget.order.id ?? '',
                              status: OrderStatus.delivered,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                if (widget.order.status == OrderStatus.delivered) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OrderStatusButton(
                          title: 'تسديد الطلب',
                          icon: Icons.payments_outlined,
                          color: OrderStatus.paid.color,
                          onTap: () async {
                            await context
                                .read<OrdersCubit>()
                                .updateOrderStatus(
                              orderId: widget.order.id ?? '',
                              status: OrderStatus.paid,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),

            OrderStatusBadge(
              color: widget.order.status.color,
              title: widget.order.status.ar,
            ),
          ],
        ),
      ),
    );
  }
}