import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/widgets/skeletonizer_customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/empty_widget.dart';
import '../view_model/clients_cubit.dart';
import 'clients_header.dart';
import 'customer_card.dart';

class ClientsViewBody extends StatelessWidget {
  const ClientsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const ClientsViewDesktop()
        : const ClientsViewMobile();
  }
}

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

              return SliverGrid.builder(
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

class ClientsViewMobile extends StatelessWidget {
  const ClientsViewMobile({super.key});

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

              return SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    right: 10,
                    left: 10,
                  ),
                  itemCount: clients.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    final client = clients[index];

                    final orders = context
                        .read<ClientsCubit>()
                        .getOrdersForUser(client.uId);

                    return CustomerCard(user: client, orders: orders);
                  },
                ),
              );
            }

            return SliverToBoxAdapter(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4);
                },
                itemBuilder: (context, index) {
                  return SkeletonizerCustomerCard();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
