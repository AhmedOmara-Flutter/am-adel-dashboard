import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import 'product_item_card.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final items = order.cartEntity.cartItems;

    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المنتجات',
            style: StyleManager.font13Weight600(context).copyWith(
              color: AppColor.textPrimary,
            ),
          ),

          SizedBox(height: 12),

          ...List.generate(
            items.length,
                (index) => Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 8,
              ),
              child: ProductItemCard(
                item: items[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}