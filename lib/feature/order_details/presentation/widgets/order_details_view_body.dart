import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_note_card_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_print_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/order_summary_card_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/payment_card_section.dart';
import 'package:am_adel_dashboard/feature/order_details/presentation/widgets/products_section.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/print_service.dart';
import 'customer_info_section.dart';
import 'delivery_address_section.dart';
import 'order_header_section.dart';

class OrderDetailsViewBody extends StatelessWidget {
  final OrderEntity order;
  final int orderNumber;

  const OrderDetailsViewBody({
    super.key,
    required this.order,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    final orderNumberText =
    orderNumber.toString().padLeft(2, '0');

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
        top: 10,
      ),
      child: Column(
        spacing: 10,
        children: [
          OrderHeaderSection(
            order: order,
          ),

          CustomerInfoSection(
            order: order,
          ),

          DeliveryAddressSection(
            order: order,
          ),

          ProductsSection(
            order: order,
          ),

          OrderNoteCardSection(
            note: order.orderNote,
          ),

          PaymentCardSection(
            paymentMethod:
            order.isCashOnDelivery == true
                ? 'Cash'
                : 'Online',
            paymentImage: order.paymentImage,
          ),

          OrderSummaryCardSection(
            subTotal:
            order.cartEntity.getTotalPrice(),
            deliveryCost:
            order.selectedLocationEntity!.cost,
          ),

          OrderPrintSection(
            onPressed: () async {
              await PrintService.printOrder(
                order,
                orderNumber,
              );
            },
          ),
        ],
      ),
    );
  }
}