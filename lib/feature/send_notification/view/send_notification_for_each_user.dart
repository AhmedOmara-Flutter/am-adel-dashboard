import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/services/notification_service.dart';
import 'package:am_adel_dashboard/core/services/services_locator.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/config_size.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/view_model/clients_cubit.dart';

import '../../../core/widgets/custom_back_button.dart';

class SendNotificationForEachUser extends StatefulWidget {
  const SendNotificationForEachUser({super.key});

  @override
  State<SendNotificationForEachUser> createState() => _SendNotificationForEachUserState();
}

class _SendNotificationForEachUserState extends State<SendNotificationForEachUser> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  UserEntity? selectedClient;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ClientsCubit>().loadData();
    });
  }

  Future<void> sendNotification() async {
    final title = titleController.text.trim();
    final body = bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      _showError('اكتب عنوان ونص الإشعار');
      return;
    }

    if (selectedClient == null) {
      _showError('اختر العميل الذي تريد إرسال الإشعار إليه');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final userData = await instance<DatabaseServices>().getData(
        path: 'users',
        uId: selectedClient!.uId,
      );

      final String? fcmToken = userData['fcmToken'];

      if (fcmToken == null || fcmToken.isEmpty) {
        throw Exception(
          'هذا العميل ليس لديه FCM Token حاليًا',
        );
      }

      await NotificationService.sendNotification(
        title: title,
        body: body,
        fcmToken: fcmToken,
      );

      if (!mounted) return;

      customShowSnakeBar(
        context,
        color: AppColor.green,
        label: 'تم إرسال الإشعار إلى ${selectedClient!.userName} 🚀',
      );

      titleController.clear();
      bodyController.clear();

      setState(() {
        selectedClient = null;
      });
    } catch (e) {
      if (!mounted) return;

      _showError(
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.red,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }

  Future<void> _showClientsBottomSheet() async {
    final clientsCubit = context.read<ClientsCubit>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.card,
      builder: (bottomSheetContext) {
        return _ClientsBottomSheet(
          clientsCubit: clientsCubit,
          selectedClient: selectedClient,
          onClientSelected: (client) {
            setState(() {
              selectedClient = client;
            });

            Navigator.pop(bottomSheetContext);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomBackButton(),
                Row(
                  children: [
                    Icon(Icons.notification_important, color: AppColor.mainColor),
                    const SizedBox(width: 8),
                    Text(
                      "اشعارات مخصصه",
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 40),
              ],
            ),
SizedBox(height: 20,),
            _buildHeader(),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildNotificationForm(),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 4,
                        child: _buildPreview(),
                      ),
                    ],
                  );
                }

                return MediaQuery.sizeOf(context).width > ConfigSize.phone
                    ? Column(
                  children: [
                    _buildNotificationForm(),
                    const SizedBox(height: 24),
                    _buildPreview(),
                  ],
                )
                    : Column(
                  children: [
                    _buildPreview(),
                    const SizedBox(height: 15),
                    _buildNotificationForm(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColor.mainColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColor.mainColor.withValues(alpha: 0.25),
            ),
          ),
          child: const Icon(
            Icons.notifications_active_rounded,
            color: AppColor.mainColor,
            size: 27,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إرسال إشعار',
                style: StyleManager.font18Weight700(context),
              ),
              const SizedBox(height: 5),
              Text(
                'أرسل إشعارًا مخصصًا لعميل محدد',
                style: StyleManager.font12Weight500(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.edit_notifications_rounded,
                color: AppColor.mainColor,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'بيانات الإشعار',
                style: StyleManager.font19Weight700(context),
              ),
            ],
          ),
          const SizedBox(height: 25),
          CustomTextFormField(
            controller: titleController,
            label: 'عنوان الإشعار',
            hintText: 'مثال: 🍕 عرض خاص ليك',
            maxLines: 1,
            onSaved: (_) {},
          ),
          const SizedBox(height: 22),
          CustomTextFormField(
            controller: bodyController,
            label: 'نص الإشعار',
            hintText: 'مثال: خصم 20% على طلبك القادم 🔥',
            maxLines: 6,
            onSaved: (_) {},
          ),
          const SizedBox(height: 25),
          _buildClientSelector(),
          const SizedBox(height: 20),
          _buildInfoBox(),
          const SizedBox(height: 25),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildClientSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إرسال إلى',
          style: StyleManager.font15Weight800(context),
        ),
        const SizedBox(height: 9),
        InkWell(
          onTap: isLoading ? null : _showClientsBottomSheet,
          borderRadius: BorderRadius.circular(13),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: selectedClient != null
                    ? AppColor.mainColor.withValues(alpha: 0.5)
                    : AppColor.border,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    selectedClient != null
                        ? Icons.person_rounded
                        : Icons.person_search_rounded,
                    color: AppColor.mainColor,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: selectedClient == null
                      ? Text(
                    'اختر العميل',
                    style: StyleManager.font13Weight400(context),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedClient!.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Weight600(context),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        selectedClient!.phone,
                        style: StyleManager.font11Weight400(context),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColor.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.mainColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.mainColor.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColor.mainColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              selectedClient == null
                  ? 'اختر عميلًا محددًا لإرسال الإشعار إليه.'
                  : 'سيتم إرسال الإشعار إلى ${selectedClient!.userName} فقط.',
              style: StyleManager.font13Weight400(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : sendNotification,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.mainColor,
          foregroundColor: AppColor.white,
          disabledBackgroundColor: AppColor.border,
          disabledForegroundColor: AppColor.textSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColor.white,
          ),
        )
            : const Icon(
          Icons.send_rounded,
          size: 20,
        ),
        label: Text(
          isLoading ? 'جاري الإرسال...' : 'إرسال الإشعار',
          style: StyleManager.font16Weight600(context).copyWith(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.phone_android_rounded,
                color: AppColor.mainColor,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'معاينة الإشعار',
                style: StyleManager.font16Weight600(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNotificationPreview(),
        ],
      ),
    );
  }

  Widget _buildNotificationPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.local_pizza_rounded,
              color: AppColor.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                titleController,
                bodyController,
              ]),
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleController.text.isEmpty
                          ? 'عنوان الإشعار'
                          : titleController.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font13Weight400(context),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      bodyController.text.isEmpty
                          ? 'نص الإشعار سيظهر هنا...'
                          : bodyController.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClientsBottomSheet extends StatefulWidget {
  const _ClientsBottomSheet({
    required this.clientsCubit,
    required this.selectedClient,
    required this.onClientSelected,
  });

  final ClientsCubit clientsCubit;
  final UserEntity? selectedClient;
  final ValueChanged<UserEntity> onClientSelected;

  @override
  State<_ClientsBottomSheet> createState() => _ClientsBottomSheetState();
}

class _ClientsBottomSheetState extends State<_ClientsBottomSheet> {
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
        height: MediaQuery.sizeOf(context).height * 0.78,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
          child: Column(
            children: [
              Container(
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.border,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Icon(
                    Icons.people_alt_rounded,
                    color: AppColor.mainColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'اختيار العميل',
                    style: StyleManager.font18Weight700(context),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.clientsCubit.clients.length} عميل',
                    style: StyleManager.font12Weight500(context),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                controller: searchController,
                onChanged: widget.clientsCubit.searchClients,
                decoration: InputDecoration(
                  hintText: 'ابحث باسم العميل...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
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
                    ),
                  ),
                  filled: true,
                  fillColor: AppColor.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
                            Icon(
                              Icons.person_off_rounded,
                              size: 45,
                              color: AppColor.textSecondary,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'لا يوجد عملاء',
                              style: StyleManager.font14Weight600(context),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: clients.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final client = clients[index];
                        final isSelected =
                            widget.selectedClient?.uId == client.uId;

                        return InkWell(
                          onTap: () {
                            widget.onClientSelected(client);
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.mainColor.withValues(alpha: 0.08)
                                  : AppColor.background,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.mainColor.withValues(alpha: 0.35)
                                    : AppColor.border,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor.withValues(
                                      alpha: 0.12,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person_rounded,
                                    color: AppColor.mainColor,
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
                                        style: StyleManager.font14Weight600(
                                          context,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        client.phone,
                                        style: StyleManager.font11Weight400(
                                          context,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  isSelected
                                      ? Icons.check_circle_rounded
                                      : Icons.arrow_forward_ios_rounded,
                                  color: isSelected
                                      ? AppColor.mainColor
                                      : AppColor.textSecondary,
                                  size: isSelected ? 22 : 15,
                                ),
                              ],
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