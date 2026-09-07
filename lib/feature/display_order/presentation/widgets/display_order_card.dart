import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../orders/presentation/widgets/order_status_badge.dart';
import 'display_product_item.dart';
import 'order_total_section.dart';

class DisplayOrderCard extends StatelessWidget {
  final OrderEntity order;
  final int orderNumber;

  const DisplayOrderCard({
    super.key,
    required this.order,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),

              Text(
                'طلب #${orderNumber.toString().padLeft(2, "0")}',
                style: StyleManager.font13Weight600(context).copyWith(
                  color: AppColor.white,
                ),
              ),

              SizedBox(height: 4),

              Text(
                order.selectedLocationEntity!.title,
                style: StyleManager.font12Weight500(context),
              ),

              SizedBox(height: 3),

              Text(
                getDateFormate(order.createdAt.toString()),
                style: StyleManager.font11Weight400(context),
              ),

              SizedBox(height: 6),

              Text(
                order.isCashOnDelivery!
                    ? 'الدفع كاش'
                    : 'دفع اونلاين',
                style: StyleManager.font12Weight500(context).copyWith(
                  color: Colors.orange,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColor.border),
              ),

              ...order.cartEntity.cartItems.map(
                    (item) => DisplayProductItem(item: item),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColor.border),
              ),

              OrderTotalSection(
                total: order.cartEntity.getTotalPrice(),
                delivery: order.selectedLocationEntity!.cost,
              ),
            ],
          ),

          Align(
            alignment: Alignment.topLeft,
            child: OrderStatusBadge(
              color: order.status.color,
              title: order.status.ar,
            ),
          ),
        ],
      ),
    );
  }
}