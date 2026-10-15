import 'package:am_adel_dashboard/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:am_adel_dashboard/core/widgets/action_button.dart';

class PausedProductButton extends StatelessWidget {
  const PausedProductButton({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final isPaused = product.isPaused;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ActionButton(
          icon: isPaused
              ? Icons.play_circle_outline
              : Icons.pause_circle_outline,
          label: isPaused ? 'تفعيل المنتج' : 'إيقاف المنتج',
          color: isPaused ? AppColor.green : AppColor.textPrimary,
          onTap: () async {
            final productsCubit = context.read<ProductsCubit>();

            final currentProduct = productsCubit.allProducts.firstWhere(
              (item) => item.id == product.id,
              orElse: () => product,
            );

            if (currentProduct.isPaused) {
              CustomShowDialog.show(
                context,
                title: 'تفعيل المنتج',
                content: Text(
                  'هل أنت متأكد أنك تريد تفعيل هذا المنتج مرة أخرى؟',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                cancel: () => Navigator.pop(context),
                accept: () {
                  productsCubit.toggleProductPaused(currentProduct.id!, false);

                  Navigator.pop(context);
                },
                flag: Icons.play_circle_outline,
                color: AppColor.green,
              );

              return;
            }

            if (currentProduct.offerId != null &&
                currentProduct.offerId!.isNotEmpty) {
              customShowSnakeBar(
                context,
                color: AppColor.red,
                label: 'لا يمكن إيقاف المنتج لأنه عليه عرض حاليًا',
              );

              return;
            }

            final cartStatusCubit = context.read<CartStatusCubit>();

            await cartStatusCubit.checkCartsStatus();

            if (!context.mounted) return;

            final cartState = cartStatusCubit.state;

            if (cartState is CartStatusLoaded) {
              if (!cartState.areAllCartsEmpty) {
                customShowSnakeBar(
                  context,
                  color: AppColor.red,
                  label: 'برجاء مسح جميع السله أولاً قبل إيقاف المنتج',
                );

                return;
              }

              CustomShowDialog.show(
                context,
                title: 'إيقاف المنتج',
                content: Text(
                  'هل أنت متأكد أنك تريد إيقاف هذا المنتج مؤقتًا؟',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                cancel: () => Navigator.pop(context),
                accept: () {
                  productsCubit.toggleProductPaused(currentProduct.id!, true);

                  Navigator.pop(context);
                },
                flag: Icons.pause_circle_outline,
                color: AppColor.red,
              );
            } else if (cartState is CartStatusError) {
              customShowSnakeBar(
                context,
                color: AppColor.red,
                label: 'حدث خطأ أثناء التحقق من السلال، حاول مرة أخرى',
              );
            }
          },
        ),
      ),
    );
  }
}
