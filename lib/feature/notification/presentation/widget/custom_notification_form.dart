import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class CustomNotificationForm extends StatelessWidget {
  const CustomNotificationForm({
    super.key,
    required this.titleController,
    required this.bodyController,
    required this.infoBox,
    required this.sendButton,
    this.titleHint = 'مثال: 🍕 عرض جديد',
    this.bodyHint = 'مثال: خصم 20% اليوم 🔥',
    this.sectionTitle = 'محتوى الإشعار',
    this.sectionSubtitle = 'اكتب الرسالة التي تريد إرسالها للعملاء',
  });

  final TextEditingController titleController;
  final TextEditingController bodyController;
  final Widget infoBox;
  final Widget sendButton;
  final String titleHint;
  final String bodyHint;
  final String sectionTitle;
  final String sectionSubtitle;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 22),
          Divider(height: 1, color: AppColor.divider.withOpacity(.45)),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 9),
              Text(
                'بيانات الرسالة',
                style: StyleManager.font13Weight400(context).copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildField(
            context,
            icon: Icons.title_rounded,
            label: 'عنوان الإشعار',
            child: CustomTextFormField(
              controller: titleController,
              hintText: titleHint,
              maxLines: 1,
              onSaved: (_) {},
            ),
          ),

          const SizedBox(height: 22),

          _buildField(
            context,
            icon: Icons.notes_rounded,
            label: 'نص الإشعار',
            child: CustomTextFormField(
              controller: bodyController,
              hintText: bodyHint,
              maxLines: 6,
              onSaved: (_) {},
            ),
          ),

          const SizedBox(height: 24),

          infoBox,

          const SizedBox(height: 20),

          SizedBox(width: double.infinity, child: sendButton),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.09),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.mainColor.withOpacity(.13)),
          ),
          child: Icon(
            Icons.edit_note_rounded,
            color: AppColor.mainColor,
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionTitle,
                style: StyleManager.font16Weight700(
                  context,
                ).copyWith(color: AppColor.textPrimary),
              ),
              const SizedBox(height: 5),
              Text(
                sectionSubtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(color: AppColor.textSecondary, height: 1.6),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.notifications_active_outlined,
          color: AppColor.mainColor.withOpacity(.65),
          size: 22,
        ),
      ],
    );
  }

  Widget _buildField(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColor.mainColor, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: StyleManager.font12Weight500(context).copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
