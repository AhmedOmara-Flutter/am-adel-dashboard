import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_note_card_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_summary_card_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/payment_card_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/products_section.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../core/widgets/custom_back_button.dart';
import 'customer_info_section.dart';
import 'delivery_address_section.dart';
import 'order_header_section.dart';

class OrderDetailsViewBody extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsViewBody({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20,top:MediaQuery.sizeOf(context).width >ConfigSize.phone?10: 30),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomBackButton(),
              Row(
                children: [
                  Icon(Icons.inventory, color: AppColor.mainColor),
                  const SizedBox(width: 8),
                  Text(
                    "تفاصيل الطلب",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 40,height: 40,),
            ],
          ),
          OrderHeaderSection(order: order, ),
          CustomerInfoSection(order: order),
          DeliveryAddressSection(order: order),
          ProductsSection(order: order),
          OrderNoteCardSection(note: order.orderNote),
          PaymentCardSection(
            paymentMethod: order.isCashOnDelivery == true ? 'Cash' : 'Online',
            paymentImage: order.paymentImage,
          ),
          OrderSummaryCardSection(
            subTotal: order.cartEntity.getTotalPrice(),
            deliveryCost: order.selectedLocationEntity!.cost,
          ),
        ],
      ),
    );
  }
}
