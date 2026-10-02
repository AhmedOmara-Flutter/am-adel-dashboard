import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/view_model/clients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsBottomSheet extends StatefulWidget {
  const ClientsBottomSheet({
    required this.clientsCubit,
    required this.selectedClient,
    required this.onClientSelected,
  });

  final ClientsCubit clientsCubit;
  final UserEntity? selectedClient;
  final ValueChanged<UserEntity> onClientSelected;

  @override
  State<ClientsBottomSheet> createState() => ClientsBottomSheetState();
}

class ClientsBottomSheetState extends State<ClientsBottomSheet> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .78,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.divider,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(
                    Icons.people_alt_rounded,
                    color: AppColor.mainColor,
                    size: 23,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اختيار العميل',
                          style: StyleManager.font18Weight700(
                            context,
                          ).copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'حدد العميل الذي سيستقبل الإشعار',
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.clientsCubit.clients.length} عميل',
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextField(
                controller: searchController,
                onChanged: widget.clientsCubit.searchClients,
                style: StyleManager.font13Weight400(
                  context,
                ).copyWith(
                  color: AppColor.textPrimary,
                ),
                cursorColor: AppColor.mainColor,
                decoration: InputDecoration(
                  hintText: 'ابحث باسم العميل...',
                  hintStyle: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColor.textSecondary,
                    size: 21,
                  ),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                    onPressed: () {
                      searchController.clear();
                      widget.clientsCubit.searchClients('');
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: AppColor.textSecondary,
                      size: 19,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColor.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColor.mainColor.withOpacity(.35),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<ClientsCubit, ClientsState>(
                  bloc: widget.clientsCubit,
                  builder: (context, state) {
                    if (state is GetClientsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.mainColor,
                        ),
                      );
                    }

                    final clients = widget.clientsCubit.filteredClients;

                    if (clients.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_search_rounded,
                              size: 42,
                              color: AppColor.textSecondary,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'لا يوجد عملاء',
                              style: StyleManager.font14Weight600(
                                context,
                              ).copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'جرب البحث باسم مختلف',
                              style: StyleManager.font11Weight400(
                                context,
                              ).copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: clients.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final client = clients[index];

                        final isSelected =
                            widget.selectedClient?.uId == client.uId;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              widget.onClientSelected(client);
                            },
                            borderRadius: BorderRadius.circular(13),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.mainColor.withOpacity(.06)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.mainColor.withOpacity(.30)
                                      : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 43,
                                    height: 43,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColor.mainColor.withOpacity(.10)
                                          : AppColor.background,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.person_rounded,
                                      color: AppColor.mainColor,
                                      size: 21,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          client.userName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                          StyleManager.font14Weight600(
                                            context,
                                          ).copyWith(
                                            color:
                                            AppColor.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          client.phone,
                                          style:
                                          StyleManager.font11Weight400(
                                            context,
                                          ).copyWith(
                                            color:
                                            AppColor.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    duration: const Duration(
                                      milliseconds: 160,
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                      Icons.check_circle_rounded,
                                      key: ValueKey('selected'),
                                      color: AppColor.mainColor,
                                      size: 21,
                                    )
                                        : const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      key: ValueKey('unselected'),
                                      color: AppColor.textSecondary,
                                      size: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}