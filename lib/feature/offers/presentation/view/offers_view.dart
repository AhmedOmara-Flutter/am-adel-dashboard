import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/feature/offers/presentation/widgets/offers_view_body.dart';

import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {


  @override
  void initState() {
    context.read<OffersCubit>().getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OffersViewBody();
  }
}
