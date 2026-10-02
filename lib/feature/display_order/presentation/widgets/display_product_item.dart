import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../cart_status/domain/entities/cart_item_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class DisplayProductItem extends StatelessWidget {
  final CartItemEntity item;

  const DisplayProductItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
      child: Row(
        children: [
          _ProductImage(imageUrl: item.product.image),

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
                  ).copyWith(color: AppColor.textPrimary, fontSize: 12),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Text(
                      '${item.unitPrice.toStringAsFixed(2)} ج.م',
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(color: AppColor.mainColor),
                    ),

                    const SizedBox(width: 7),

                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColor.textSecondary.withOpacity(.4),
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 7),

                    Text(
                      'للوحدة',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(color: AppColor.textSecondary.withOpacity(.7)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          _Quantity(quantity: item.quantity),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String? imageUrl;

  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(13),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          fit: BoxFit.contain,
          placeholder: (_, __) {
            return Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 1.8,
                  color: AppColor.mainColor,
                ),
              ),
            );
          },
          errorWidget: (_, __, ___) {
            return Icon(
              Icons.image_outlined,
              size: 21,
              color: AppColor.textSecondary.withOpacity(.5),
            );
          },
        ),
      ),
    );
  }
}

class _Quantity extends StatelessWidget {
  final int quantity;

  const _Quantity({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الكمية',
          style: StyleManager.font11Weight400(context).copyWith(
            color: AppColor.textSecondary.withOpacity(.65),
            fontSize: 9,
          ),
        ),

        const SizedBox(height: 4),

        Container(
          constraints: const BoxConstraints(minWidth: 30),
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$quantity',
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(color: AppColor.mainColor, fontSize: 11),
          ),
        ),
      ],
    );
  }
}
