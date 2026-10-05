import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';

import '../view_model/delete_flash_offer_cubit/delete_flash_offer_cubit.dart';
import '../view_model/get_flash_offer_cubit/get_flash_offer_cubit.dart';

import 'flash_offer_card.dart';

class FlashOfferViewBody extends StatelessWidget {
  const FlashOfferViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFlashOfferCubit, GetFlashOfferState>(
      builder: (context, state) {
        if (state is GetFlashOfferLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.mainColor,
              strokeWidth: 2,
            ),
          );
        }

        if (state is GetFlashOfferFailure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        if (state is GetFlashOfferSuccess) {
          final flashOffers = state.flashOffers;

          if (flashOffers.isEmpty) {
            return Center(
              child: Lottie.asset(
                Assets.assets.json.empty,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: flashOffers.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 12);
            },
            itemBuilder: (context, index) {
              final flashOffer = flashOffers[index];

              return FlashOfferCard(
                flashOffer: flashOffer,
                onDelete: () {
                  CustomShowDialog.show(
                    context,
                    title: 'حذف العرض',
                    content: Text(
                      'هل أنت متأكد أنك تريد حذف هذا الـ Flash Offer؟',
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(
                        height: 1.5,
                        color: AppColor.textSecondary,
                      ),
                    ),
                    cancel: () {
                      Navigator.pop(context);
                    },
                    accept: () async {
                      Navigator.pop(context);

                      await context
                          .read<DeleteFlashOfferCubit>()
                          .deleteFlashOffer(
                        flashOffer,
                      );
                    },
                    flag: Icons.flash_on_rounded,
                    color: AppColor.red,
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}