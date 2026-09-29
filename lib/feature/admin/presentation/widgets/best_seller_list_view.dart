import 'package:am_adel_dashboard/feature/admin/presentation/widgets/product_item.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/skeletonizer_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.watch<OrdersCubit>();
        bool isLoading = cubit.state is GetOrdersLoadingState;
        final topProducts = cubit.topProducts;

        if (isLoading)
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => SkeletonizerProductItem(),
          );

        if (topProducts.isEmpty) {
          return Container(
            margin: EdgeInsets.only(bottom: 20, top: 15),
            child: Text(
              'لا يوجد حاليا اكثر منتجات مبيعا',
              style: StyleManager.font15Weight800(context).copyWith(
                fontSize: 13
              ),

            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topProducts.take(5).length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return ProductItem(
                productName: topProducts[index].name,
                orderCount: topProducts[index].totalOrders.toString(),
                image: topProducts[index].image,
                medal: cubit.medals[index],
              );
            });
      },
    );
  }
}
