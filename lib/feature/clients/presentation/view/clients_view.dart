import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/clients_cubit.dart';
import '../widgets/clients_view_body.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({super.key});

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  @override
  void initState() {
    super.initState();
   context.read<ClientsCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ClientsViewBody();
  }
}
