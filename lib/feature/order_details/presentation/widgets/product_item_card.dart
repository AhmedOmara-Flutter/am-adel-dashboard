import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/cart_status/domain/entities/cart_item_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.item,
  });
  final CartItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: item.product.image!,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 58,
                height: 58,
                color: AppColor.card,
              ),
              errorWidget: (_, __, ___) => Container(
                width: 58,
                height: 58,
                color: AppColor.card,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColor.textSecondary,
                  size: 18,
                ),
              ),
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  '${item.unitPrice.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font13Weight700(context),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.mainColor.withOpacity(.25),
              ),
            ),
            child: Text(
              '×${item.quantity}',
              style: StyleManager.font13Weight700(context),
            ),
          ),
        ],
      ),
    );
  }
}