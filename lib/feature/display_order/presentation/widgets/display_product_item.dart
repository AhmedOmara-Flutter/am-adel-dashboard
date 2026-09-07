import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../cart_status/domain/entities/cart_item_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class DisplayProductItem extends StatelessWidget {
  final CartItemEntity item;

  const DisplayProductItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: item.product.image ?? '',
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
                ),
              ),
            ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: StyleManager.font13Weight600(context).copyWith(
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  '${item.unitPrice.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.mainColor,
                  ),
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
              color: AppColor.mainColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '×${item.quantity}',
              style: StyleManager.font13Weight600(context).copyWith(
                color: AppColor.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}