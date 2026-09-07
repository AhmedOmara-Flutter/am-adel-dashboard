import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';
import '../view_model/delete_bundle_offer_cubit/delete_bundle_offer_cubit.dart';
import '../view_model/get_bundle_offer_cubit/get_bundle_offer_cubit.dart';
import 'bundle_offer_card.dart';

class BundleOfferViewBody extends StatelessWidget {
  const BundleOfferViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBundleOfferCubit, GetBundleOfferState>(
      builder: (context, state) {
        if (state is GetBundleOfferLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.mainColor,
              strokeWidth: 2,
            ),
          );
        }

        if (state is GetBundleOfferFailure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        if (state is GetBundleOfferSuccess) {
          final bundleOffers = state.bundleOffers;

          if (bundleOffers.isEmpty) {
            return Center(
              child: Lottie.asset(
                Assets.assets.json.empty,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: bundleOffers.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              final bundleOffer = bundleOffers[index];

              return BundleOfferCard(
                bundleOffer: bundleOffer,
                onDelete: () {
                  CustomShowDialog.show(
                    context,
                    title: 'حذف الباكدج',
                    content: const Text(
                      'هل أنت متأكد أنك تريد حذف هذا الباكدج؟',
                      textAlign: TextAlign.center,
                    ),
                    cancel: () {
                      Navigator.pop(context);
                    },
                    accept: () async {
                      Navigator.pop(context);

                      await context
                          .read<DeleteBundleOfferCubit>()
                          .deleteBundleOffer(
                        bundleOffer,
                      );
                    },
                    flag: Icons.local_offer_outlined,
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