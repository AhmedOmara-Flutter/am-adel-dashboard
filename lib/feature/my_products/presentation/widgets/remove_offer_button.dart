import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';

import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/entities/offer_entity.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../cart_status/presentation/view_model/cart_status_cubit.dart';
import 'add_offer_bottom_sheet.dart';

class RemoveOfferButton extends StatelessWidget {
  const RemoveOfferButton({
    super.key,
    required this.hasOffer,
    required this.offer,
    required this.product,
  });

  final bool hasOffer;
  final OfferEntity? offer;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OffersCubit, OfferState>(
      listener: (context, state) {
        if (state is DeleteOfferFailure) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );
        }
      },
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: hasOffer
                ? AppColor.mainColor.withOpacity(0.8)
                : AppColor.card,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColor.border),
          ),
          child: InkWell(
            onTap: () async {
              if (hasOffer) {
                CustomShowDialog.show(
                  context,
                  title: 'حذف العرض',
                  content: Text(
                    'هل أنت متأكد أنك تريد حذف هذا العرض؟',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                  cancel: () => Navigator.pop(context),
                  accept: () {
                    context.read<OffersCubit>().deleteOffer(offer!);
                    Navigator.pop(context);
                  },
                  flag: Icons.local_offer_outlined,
                  color: AppColor.red,
                );

                return;
              }

              final cartStatusCubit = context.read<CartStatusCubit>();

              await cartStatusCubit.checkCartsStatus();

              final cartState = cartStatusCubit.state;
              if (cartState is CartStatusLoaded) {
                if (!cartState.areAllCartsEmpty) {
                  customShowSnakeBar(
                    context,
                    color: AppColor.red,
                    label: 'برجاء مسح جميع السله أولاً قبل إضافة العرض',
                  );

                  return;
                }
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColor.background,
                  builder: (_) => AddOfferBottomSheet(product: product),
                );
              } else if (cartState is CartStatusError) {
                customShowSnakeBar(
                  context,
                  color: AppColor.red,
                  label: 'حدث خطأ أثناء التحقق من السلال، حاول مرة أخرى',
                );
              }
            },
            child: Text(
              hasOffer ? 'حذف عرض' : 'إضافة عرض',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
