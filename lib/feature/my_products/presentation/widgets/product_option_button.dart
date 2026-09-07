import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/products_cubit/products_cubit.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/route_manager.dart';
import '../../../cart_status/presentation/view_model/cart_status_cubit.dart';

class ProductOptionButton extends StatelessWidget {
  const ProductOptionButton({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10,
      left: -18,
      child: PopupMenuButton<String>(
        tooltip: 'خيارات المنتج',
        icon: Icon(
          Icons.more_vert,
          color: AppColor.textSecondary,
          size: 24,
        ),
        color: AppColor.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        onSelected: (value) async {
          // =========================
          // تعديل المنتج
          // =========================
          if (value == 'edit') {
            final cartStatusCubit =
            context.read<CartStatusCubit>();

            await cartStatusCubit.checkCartsStatus();

            final cartState = cartStatusCubit.state;

            if (cartState is CartStatusLoaded) {
              // يوجد منتجات في إحدى السلال
              if (!cartState.areAllCartsEmpty) {
                customShowSnakeBar(
                  context,
                  color: AppColor.red,
                  label:
                  'برجاء إفراغ جميع السلال أولاً قبل تعديل المنتج',
                );
                return;
              }

              // جميع السلال فارغة
              Navigator.pushNamed(
                context,
                RouteManager.editProductView,
                arguments: product,
              );
            } else if (cartState is CartStatusError) {
              customShowSnakeBar(
                context,
                color: AppColor.red,
                label:
                'حدث خطأ أثناء التحقق من السلال، حاول مرة أخرى',
              );
            }
          }

          // =========================
          // حذف المنتج
          // =========================
          if (value == 'delete') {
            CustomShowDialog.show(
              context,
              title: 'حذف المنتج',
              content: Text(
                'هل أنت متأكد أنك تريد حذف هذا المنتج؟',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
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
          }
        },

        itemBuilder: (context) => [
          PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: AppColor.mainColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'تعديل المنتج',
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: AppColor.red,
                ),
                const SizedBox(width: 10),
                Text(
                  'حذف المنتج',
                  style: TextStyle(
                    color: AppColor.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}