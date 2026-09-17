import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/products_cubit/products_cubit.dart';
import '../../../cart_status/presentation/view_model/cart_status_cubit.dart';

class PausedProductButton extends StatelessWidget {
  const PausedProductButton({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final isPaused = product.isPaused;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isPaused
              ? AppColor.red.withOpacity(.10)
              : AppColor.cardLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPaused
                ? AppColor.red.withOpacity(.35)
                : AppColor.divider,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            if (product.isPaused) {
              CustomShowDialog.show(
                context,
                title: 'تفعيل المنتج',
                content: Text(
                  'هل أنت متأكد أنك تريد تفعيل هذا المنتج مرة أخرى؟',
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
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
                      .toggleProductPaused(
                    product.id!,
                    false,
                  );

                  Navigator.pop(context);
                },
                flag: Icons.play_circle_outline,
                color: AppColor.green,
              );

              return;
            }

            final cartStatusCubit =
            context.read<CartStatusCubit>();

            await cartStatusCubit.checkCartsStatus();

            final cartState = cartStatusCubit.state;

            if (cartState is CartStatusLoaded) {
              if (!cartState.areAllCartsEmpty) {
                customShowSnakeBar(
                  context,
                  color: AppColor.red,
                  label:
                  'برجاء مسح جميع السله أولاً قبل إيقاف المنتج',
                );

                return;
              }

              CustomShowDialog.show(
                context,
                title: 'إيقاف المنتج',
                content: Text(
                  'هل أنت متأكد أنك تريد إيقاف هذا المنتج مؤقتًا؟',
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
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
                      .toggleProductPaused(
                    product.id!,
                    true,
                  );

                  Navigator.pop(context);
                },
                flag: Icons.pause_circle_outline,
                color: AppColor.red,
              );
            } else if (cartState is CartStatusError) {
              customShowSnakeBar(
                context,
                color: AppColor.red,
                label:
                'حدث خطأ أثناء التحقق من السلال، حاول مرة أخرى',
              );
            }
          },
          child: Text(
            isPaused ? 'تفعيل المنتج' : 'إيقاف المنتج',
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .titleSmall!
                .copyWith(
              color: isPaused
                  ? AppColor.red
                  : AppColor.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
