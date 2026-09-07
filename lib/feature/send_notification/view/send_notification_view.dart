import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/send_notification/view/send_notification_for_each_user.dart';

import '../../../core/services/notification_service.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/config_size.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class SendNotificationView extends StatefulWidget {
  const SendNotificationView({super.key});

  @override
  State<SendNotificationView> createState() => _SendNotificationViewState();
}

class _SendNotificationViewState extends State<SendNotificationView> {
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _buildNotificationForm()),
                    const SizedBox(width: 24),
                    Expanded(flex: 4, child: _buildPreview()),
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
              Text('إرسال إشعار', style: StyleManager.font18Weight700(context)),
              const SizedBox(height: 5),
              Text(
                'أرسل إشعارًا فوريًا لجميع مستخدمي التطبيق',
                style: StyleManager.font12Weight500(context),
              ),
            ],
          ),
        ),
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>SendNotificationForEachUser() ,));
        }, icon: Icon(Icons.add))


      ],
    );
  }

  Widget _buildNotificationForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.border),
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
            hintText: 'مثال: 🍕 عرض جديد',
            maxLines: 1,
            onSaved: (_) {},
          ),
          const SizedBox(height: 22),
          CustomTextFormField(
            controller: bodyController,
            label: 'نص الإشعار',
            hintText: 'مثال: خصم 20% اليوم 🔥',
            maxLines: 6,
            onSaved: (_) {},
          ),
          const SizedBox(height: 25),
          _buildInfoBox(),
          const SizedBox(height: 25),
          SizedBox(
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
                  : const Icon(Icons.send_rounded, size: 20),
              label: Text(
                isLoading ? 'جاري الإرسال...' : 'إرسال الإشعار',
                style: StyleManager.font16Weight600(
                  context,
                ).copyWith(color: AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.mainColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.mainColor.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: AppColor.mainColor, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'سيتم إرسال هذا الإشعار لجميع المستخدمين المشتركين في التطبيق.',
              style: StyleManager.font13Weight400(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.border),
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
        border: Border.all(color: AppColor.border),
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
              animation: Listenable.merge([titleController, bodyController]),
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
