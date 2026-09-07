import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/paused_product_button.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/remove_offer_button.dart';
import '../../../../core/entities/offer_entity.dart';

class ProductActionsSection extends StatelessWidget {
  final ProductEntity product;
  final bool hasOffer;
  final OfferEntity? offer;

  const ProductActionsSection({
    super.key,
    required this.hasOffer,
    required this.product,
    this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RemoveOfferButton(
          hasOffer: hasOffer,
          offer: offer,
          product: product,
        ),
        SizedBox(width: 10),
        PausedProductButton(product: product),
      ],
    );
  }
}
