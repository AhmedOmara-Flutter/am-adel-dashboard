import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/cart_status/domain/entities/cart_item_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.item,
  });

  final CartItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColor.divider.withOpacity(.55),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.025),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: CachedNetworkImage(
                imageUrl: item.product.image ?? '',
                width: 58,
                height: 58,
                fit: BoxFit.contain,
                placeholder: (_, __) =>
                    Icon(
                      Icons.image_outlined,
                      color: AppColor.textSecondary.withOpacity(.6),
                      size: 21,
                    ),
                errorWidget: (_, __, ___) =>
                    Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColor.textSecondary.withOpacity(.6),
                      size: 20,
                    ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font13Weight600(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Text(
                      '${item.unitPrice.toStringAsFixed(2)} ج.م',
                      style: StyleManager.font13Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColor.textSecondary.withOpacity(.45),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'سعر الوحدة',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'الكمية',
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(
                  color: AppColor.textSecondary,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '×${item.quantity}',
                style: StyleManager.font13Weight700(
                  context,
                ).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
