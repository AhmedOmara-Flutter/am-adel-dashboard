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
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.divider,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.divider,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: CachedNetworkImage(
                imageUrl: item.product.image!,
                width: 58,
                height: 58,
                fit: BoxFit.contain,
                placeholder: (_, __) => Container(
                  width: 58,
                  height: 58,
                  color: AppColor.backgroundDark,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColor.textSecondary,
                    size: 20,
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 58,
                  height: 58,
                  color: AppColor.backgroundDark,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColor.textSecondary,
                    size: 18,
                  ),
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
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  '${item.unitPrice.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font13Weight700(context).copyWith(
                    color: AppColor.mainColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.divider,
              ),
            ),
            child: Text(
              '×${item.quantity}',
              style: StyleManager.font13Weight700(context).copyWith(
                color: AppColor.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}