import 'package:am_adel_dashboard/core/entities/offer_entity.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/product_actions_section.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/product_option_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final OfferEntity? offer;

  const ProductCard({
    super.key,
    required this.product,
    this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasOffer = offer != null;
    final discount = offer?.discountPercentage ?? 0;
    final oldPrice = offer?.priceBeforeDiscount ?? product.price;
    final newPrice = offer?.priceAfterDiscount ?? product.price;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.10),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: const Border(
          bottom: BorderSide(
            color: AppColor.divider,
          ),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 95,
                        height: 95,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColor.divider,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.image ?? '',
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                          const Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(
                            Icons.image_not_supported,
                            color: AppColor.textSecondary,
                            size: 32,
                          ),
                        ),
                      ),

                      if (hasOffer)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '-${discount.toInt()}%',
                              style: const TextStyle(
                                color: AppColor.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),

                        const SizedBox(height: 10),

                        hasOffer
                            ? Row(
                          children: [
                            Flexible(
                              child: Text(
                                '$oldPrice ج',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                  color:
                                  AppColor.textSecondary,
                                  decoration:
                                  TextDecoration.lineThrough,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Flexible(
                              child: Text(
                                '$newPrice ج',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                  color: AppColor.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        )
                            : Text(
                          '${product.price} ج',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              if (hasOffer)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.goldLight.withOpacity(.20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColor.accentColor.withOpacity(.35),
                    ),
                  ),
                  child: Text(
                    '📅 من ${_formatDate(offer!.startDate)} ← إلى ${_formatDate(
                        offer!.endDate)}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              ProductActionsSection(
                product: product,
                hasOffer: hasOffer,
                offer: offer,
              ),
            ],
          ),

          ProductOptionButton(
            product: product,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
