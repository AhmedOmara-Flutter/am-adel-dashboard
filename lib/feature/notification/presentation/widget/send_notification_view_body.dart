import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/app_color.dart';
import 'custom_notification_form.dart';
import 'custom_notification_info_box.dart';
import 'custom_notification_page_header.dart';
import 'custom_notification_preview.dart';
import 'custom_notification_send_button.dart';

class SendNotificationViewBody extends StatefulWidget {
  const SendNotificationViewBody({super.key});

  @override
  State<SendNotificationViewBody> createState() => _SendNotificationViewBodyState();
}

class _SendNotificationViewBodyState extends State<SendNotificationViewBody> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  bool isLoading = false;

  Future<void> sendNotification() async {
    final title = titleController.text.trim();
    final body = bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.red,
          behavior: SnackBarBehavior.floating,
          content: const Text(
            'اكتب عنوان ونص الإشعار',
            style: TextStyle(color: AppColor.white),
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await NotificationService.sendNotification(
        title: title,
        body: body,
        topic: 'all_users',
      );

      if (!mounted) return;

      customShowSnakeBar(
        context,
        color: AppColor.green,
        label: 'تم إرسال الإشعار بنجاح 🚀',
      );

      titleController.clear();
      bodyController.clear();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'حدث خطأ: $e',
            style: const TextStyle(color: AppColor.white),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNotificationPageHeader(
            title: 'إرسال إشعار عام',
            subtitle: 'أرسل إشعارًا إلى جميع العملاء',
            icon: Icons.notifications_active_rounded,
            badgeText: 'إشعار عام',
            badgeIcon: Icons.campaign_rounded,
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
                        'اكتب الرسالة التي تريد إرسالها للعملاء',
                        titleHint: 'مثال: 🍕 عرض جديد',
                        bodyHint: 'مثال: خصم 20% اليوم 🔥',
                        infoBox: CustomNotificationInfoBox(
                          title: 'الإرسال العام',
                          description:
                          'سيصل هذا الإشعار إلى جميع المستخدمين المشتركين في الإشعارات العامة.',
                          badgeText: 'ALL USERS',
                        ),
                        sendButton: CustomNotificationSendButton(
                          isLoading: isLoading,
                          onPressed: sendNotification,
                          text: 'إرسال الإشعار للجميع',
                          loadingText: 'جاري إرسال الإشعار...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                    Expanded(
                      flex: 4,
                      child: CustomNotificationPreview(
                        titleController: titleController,
                        bodyController: bodyController,
                        senderName: 'AM Adel',
                        notificationType: 'إشعار عام',
                      ),
                    ),
                  ],
                );
              }

              if (context.isDesktop) {
                return Column(
                  children: [
                    CustomNotificationForm(
                      titleController: titleController,
                      bodyController: bodyController,
                      sectionTitle: 'محتوى الإشعار',
                      sectionSubtitle:
                      'اكتب الرسالة التي تريد إرسالها للعملاء',
                      titleHint: 'مثال: 🍕 عرض جديد',
                      bodyHint: 'مثال: خصم 20% اليوم 🔥',
                      infoBox: CustomNotificationInfoBox(
                        title: 'الإرسال العام',
                        description:
                        'سيصل هذا الإشعار إلى جميع المستخدمين المشتركين في الإشعارات العامة.',
                        badgeText: 'ALL USERS',
                      ),
                      sendButton: CustomNotificationSendButton(
                        isLoading: isLoading,
                        onPressed: sendNotification,
                        text: 'إرسال الإشعار للجميع',
                        loadingText: 'جاري إرسال الإشعار...',
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomNotificationPreview(
                      titleController: titleController,
                      bodyController: bodyController,
                      senderName: 'AM Adel',
                      notificationType: 'إشعار عام',
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  CustomNotificationPreview(
                    titleController: titleController,
                    bodyController: bodyController,
                    senderName: 'AM Adel',
                    notificationType: 'إشعار عام',
                  ),
                  const SizedBox(height: 10),
                  CustomNotificationForm(
                    titleController: titleController,
                    bodyController: bodyController,
                    sectionTitle: 'محتوى الإشعار',
                    sectionSubtitle: 'اكتب الرسالة التي تريد إرسالها للعملاء',
                    titleHint: 'مثال: 🍕 عرض جديد',
                    bodyHint: 'مثال: خصم 20% اليوم 🔥',
                    infoBox: CustomNotificationInfoBox(
                      title: 'الإرسال العام',
                      description:
                      'سيصل هذا الإشعار إلى جميع المستخدمين المشتركين في الإشعارات العامة.',
                      badgeText: 'ALL USERS',
                    ),
                    sendButton: CustomNotificationSendButton(
                      isLoading: isLoading,
                      onPressed: sendNotification,
                      text: 'إرسال الإشعار للجميع',
                      loadingText: 'جاري إرسال الإشعار...',
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
}
