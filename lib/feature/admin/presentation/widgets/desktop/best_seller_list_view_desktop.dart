import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/product_item_desktop.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/skeletonizer_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';

class BestSellerListViewDesktop extends StatelessWidget {
  const BestSellerListViewDesktop({super.key});

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
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.mainColor.withOpacity(.06),
                    border: Border.all(
                      color: AppColor.border.withOpacity(.25),
                    ),
                  ),
                  child: Icon(
                    Icons.receipt_long_outlined,
                    size: 25,
                    color: AppColor.textSecondary.withOpacity(.65),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'لا يوجد حاليا اكثر منتجات مبيعا',
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ستظهر المنتجات الحديثه هنا',
                  style: StyleManager.font11Weight400(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary.withOpacity(.70),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topProducts.take(5).length,
            separatorBuilder: (context, index) =>Container(
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 5),
              color: AppColor.divider.withOpacity(.65),
            ),
            itemBuilder: (context, index) {
              return ProductItemDesktop(
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
