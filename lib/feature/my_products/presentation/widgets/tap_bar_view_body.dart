import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/empty_products_widget.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/product_card.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/skeletonizer_product_card.dart';
import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/cubit/products_cubit/products_cubit.dart';
import '../../../../core/entities/offer_entity.dart';
import '../../../../core/helper_function/get_dummy_products.dart';

class TapBarViewBody extends StatelessWidget {
  final String category;
  final String? size;

  const TapBarViewBody({
    super.key,
    required this.category,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();

        var products = cubit.allProducts.where((product) {
          return product.category == category;
        }).toList();

        if (size != null) {
          products = products.where((product) {
            return product.size == size;
          }).toList();
        }

        final offers = context.watch<OffersCubit>().offers;

        if (state is GetFilteredProductsLoading) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return SkeletonizerProductCard(getDummyProduct);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 5);
            },
            itemCount: getDummyProducts.length,
          );
        }

        if (state is GetFilteredProductsError) {
          return Center(
            child: Text(state.errMessage),
          );
        }

        if (products.isEmpty) {
          return const EmptyProductsWidget();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            final offer = offers.cast<OfferEntity?>().firstWhere(
                  (e) => e?.productId == product.id,
              orElse: () => null,
            );

            return ProductCard(
              product: product,
              offer: offer,
            );
          },
        );
      },
    );
  }
}