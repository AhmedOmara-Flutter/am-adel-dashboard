import 'package:am_adel_dashboard/feature/clients/presentation/widgets/skeletonizer_customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../view_model/clients_cubit.dart';
import 'clients_header.dart';
import 'customer_card.dart';

class ClientsViewDesktop extends StatelessWidget {
  const ClientsViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: ClientsHeader()),
        BlocBuilder<ClientsCubit, ClientsState>(
          builder: (context, state) {
            if (state is SearchClientsEmpty) {
              return const SliverFillRemaining(
                child: Center(child: Text('لا يوجد عميل بهذا الاسم')),
              );
            }

            if (state is GetClientsSuccess) {
              final clients = context.read<ClientsCubit>().filteredClients;

              if (clients.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyWidget(),
                );
              }

              return SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                sliver: SliverGrid.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                
                    final orders = context.read<ClientsCubit>().getOrdersForUser(
                      client.uId,
                    );
                
                    return CustomerCard(user: client, orders: orders);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.9,
                  ),
                ),
              );
            }

            return SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return SkeletonizerCustomerCard();
              },
            );
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 15)),
      ],
    );
  }
}
