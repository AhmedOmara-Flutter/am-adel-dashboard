import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';

import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/cubit/products_cubit/products_cubit.dart';
import '../../../../core/entities/offer_entity.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import 'add_offer_bottom_sheet.dart';

class RemoveProductButton extends StatelessWidget {
  const RemoveProductButton({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is DeleteProductError) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.errMessage,
          );
        }
      },
      child: Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColor.red.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColor.red.withOpacity(0.7),
            ),
          ),
          child: InkWell(
            onTap: () {
              CustomShowDialog.show(
                context,
                title: 'حذف المنتج',
                content: Text(
                  'هل أنت متأكد أنك تريد حذف هذا المنتج؟',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                cancel: () => Navigator.pop(context),
                accept: () {
                  context
                      .read<ProductsCubit>()
                      .deleteProduct(product.id ?? '');
                  Navigator.pop(context);
                },
                flag: Icons.shopping_bag,
                color: AppColor.red,
              );
            },
            child: Text(
              'حذف',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
