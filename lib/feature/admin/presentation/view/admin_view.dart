import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../widgets/admin_view_body.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {

  @override
  void initState() {
    super.initState();
    final ordersCubit = context.read<OrdersCubit>();
    final offersCubit = context.read<OffersCubit>();

    if (ordersCubit.allOrders.isEmpty) {
      ordersCubit.getOrders();
    }

    if (offersCubit.offers.isEmpty) {
      offersCubit.getOffers();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminViewBody(),
    );
  }
}





