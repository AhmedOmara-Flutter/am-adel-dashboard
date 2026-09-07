import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/feature/offers/presentation/widgets/skeletonizer_offer_product_card.dart';
import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../core/entities/offer_entity.dart';
import 'offer_product_card.dart';

class OffersViewBody extends StatelessWidget {
  const OffersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OfferState>(
      builder: (context, state) {
        final cubit = context.read<OffersCubit>();
        final offers = cubit.offers;

        if (state is GetOffersLoading) {
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(height: 5),
            itemBuilder: (context, index) {
              return SkeletonizerOfferProductCard();
            },
          );
        }

        if (state is GeOffersFailure) {
          return Center(child: Text(state.errMessage));
        }

        if (offers.isEmpty) {
          return const EmptyWidget();
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: offers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            return OfferProductCard(offer: offers[index]);
          },
        );
      },
    );
}}