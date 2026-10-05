import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/services/notification_service.dart';
import 'package:am_adel_dashboard/core/services/services_locator.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/config_size.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/view_model/clients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/clients_bottom_sheet.dart';
import '../widget/custom_notification_form.dart';
import '../widget/custom_notification_info_box.dart';
import '../widget/custom_notification_page_header.dart';
import '../widget/custom_notification_preview.dart';
import '../widget/custom_notification_send_button.dart';

class SendNotificationForEachUserBody extends StatefulWidget {
  const SendNotificationForEachUserBody({super.key});

  @override
  State<SendNotificationForEachUserBody> createState() =>
      _SendNotificationForEachUserBodyState();
}

class _SendNotificationForEachUserBodyState
    extends State<SendNotificationForEachUserBody> {
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
        throw Exception('هذا العميل ليس لديه FCM Token حاليًا');
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

      _showError(e.toString().replaceFirst('Exception: ', ''));
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
          style: const TextStyle(color: AppColor.textOnDark),
        ),
      ),
    );
  }

  Future<void> _showClientsBottomSheet() async {
    final clientsCubit = context.read<ClientsCubit>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.cardLight,
      builder: (bottomSheetContext) {
        return ClientsBottomSheet(
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNotificationPageHeader(
            title: 'إرسال إشعار مخصص',
            subtitle: 'أرسل رسالة خاصة إلى عميل محدد',
            icon: Icons.person_pin_circle_rounded,
            badgeText: 'إشعار خاص',
            badgeIcon: Icons.person_rounded,
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 1000) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomNotificationForm(
                        titleController: titleController,
                        bodyController: bodyController,
                        sectionTitle: 'محتوى الإشعار',
                        sectionSubtitle:
                            'اكتب الرسالة التي تريد إرسالها للعميل',
                        titleHint: 'مثال: 🍕 عرض خاص ليك',
                        bodyHint: 'مثال: خصم 20% على طلبك القادم 🔥',
                        infoBox: Column(
                          children: [
                            _buildClientSelector(),
                            const SizedBox(height: 20),
                            CustomNotificationInfoBox(
                              title: 'إشعار مخصص',
                              description:
                                  'سيتم إرسال هذا الإشعار إلى العميل المحدد فقط.',
                              badgeText: 'PRIVATE',
                              icon: Icons.person_rounded,
                            ),
                          ],
                        ),
                        sendButton: CustomNotificationSendButton(
                          isLoading: isLoading,
                          onPressed: sendNotification,
                          text: 'إرسال الإشعار للعميل',
                          loadingText: 'جاري إرسال الإشعار...',
                          icon: Icons.person,
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                    Expanded(
                      flex: 4,
                      child: CustomNotificationPreview(
                        titleController: titleController,
                        bodyController: bodyController,
                        senderName: selectedClient?.userName ?? 'AM Adel',
                        notificationType: 'إشعار خاص',
                      ),
                    ),
                  ],
                );
              }

              return context.isDesktop
                  ? Column(
                      children: [
                        CustomNotificationForm(
                          titleController: titleController,
                          bodyController: bodyController,
                          sectionTitle: 'محتوى الإشعار',
                          sectionSubtitle:
                              'اكتب الرسالة التي تريد إرسالها للعميل',
                          titleHint: 'مثال: 🍕 عرض خاص ليك',
                          bodyHint: 'مثال: خصم 20% على طلبك القادم 🔥',
                          infoBox: Column(
                            children: [
                              _buildClientSelector(),
                              const SizedBox(height: 20),
                              CustomNotificationInfoBox(
                                title: 'إشعار مخصص',
                                description:
                                    'سيتم إرسال هذا الإشعار إلى العميل المحدد فقط.',
                                badgeText: 'PRIVATE',
                                icon: Icons.person_rounded,
                              ),
                            ],
                          ),
                          sendButton: CustomNotificationSendButton(
                            isLoading: isLoading,
                            onPressed: sendNotification,
                            text: 'إرسال الإشعار للعميل',
                            loadingText: 'جاري إرسال الإشعار...',
                            icon: Icons.person,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomNotificationPreview(
                          titleController: titleController,
                          bodyController: bodyController,
                          senderName: selectedClient?.userName ?? 'AM Adel',
                          notificationType: 'إشعار خاص',
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        CustomNotificationPreview(
                          titleController: titleController,
                          bodyController: bodyController,
                          senderName: selectedClient?.userName ?? 'AM Adel',
                          notificationType: 'إشعار خاص',
                        ),
                        const SizedBox(height: 10),
                        CustomNotificationForm(
                          titleController: titleController,
                          bodyController: bodyController,
                          sectionTitle: 'محتوى الإشعار',
                          sectionSubtitle:
                              'اكتب الرسالة التي تريد إرسالها للعميل',
                          titleHint: 'مثال: 🍕 عرض خاص ليك',
                          bodyHint: 'مثال: خصم 20% على طلبك القادم 🔥',
                          infoBox: Column(
                            children: [
                              _buildClientSelector(),
                              const SizedBox(height: 20),
                              CustomNotificationInfoBox(
                                title: 'إشعار مخصص',
                                description:
                                    'سيتم إرسال هذا الإشعار إلى العميل المحدد فقط.',
                                badgeText: 'PRIVATE',
                                icon: Icons.person_rounded,
                              ),
                            ],
                          ),
                          sendButton: CustomNotificationSendButton(
                            isLoading: isLoading,
                            onPressed: sendNotification,
                            text: 'إرسال الإشعار للعميل',
                            loadingText: 'جاري إرسال الإشعار...',
                            icon: Icons.person,
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColor.mainColor),
        const SizedBox(width: 7),
        Text(
          label,
          style: StyleManager.font12Weight500(
            context,
          ).copyWith(color: AppColor.textPrimary),
        ),
      ],
    );
  }

  Widget _buildClientSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(
          icon: Icons.person_search_rounded,
          label: 'العميل المستهدف',
        ),
        const SizedBox(height: 9),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : _showClientsBottomSheet,
            borderRadius: BorderRadius.circular(15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selectedClient != null
                    ? AppColor.mainColor.withOpacity(.045)
                    : AppColor.background,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: selectedClient != null
                      ? AppColor.mainColor.withOpacity(.35)
                      : AppColor.border.withOpacity(.35),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: selectedClient != null
                          ? AppColor.mainColor.withOpacity(.10)
                          : AppColor.backgroundDark,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      selectedClient != null
                          ? Icons.person_rounded
                          : Icons.person_search_rounded,
                      color: AppColor.mainColor,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: selectedClient == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اختر العميل',
                                style: StyleManager.font13Weight600(
                                  context,
                                ).copyWith(color: AppColor.textPrimary),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'حدد العميل الذي سيستقبل الإشعار',
                                style: StyleManager.font11Weight400(
                                  context,
                                ).copyWith(color: AppColor.textSecondary),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedClient!.userName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StyleManager.font14Weight600(
                                  context,
                                ).copyWith(color: AppColor.textPrimary),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                selectedClient!.phone,
                                style: StyleManager.font11Weight400(
                                  context,
                                ).copyWith(color: AppColor.textSecondary),
                              ),
                            ],
                          ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColor.textSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
