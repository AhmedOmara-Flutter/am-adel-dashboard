import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColor.border.withOpacity(.24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),

          const SizedBox(height: 26),

          _buildField(
            context,
            icon: Icons.title_outlined,
            label: 'عنوان الإشعار',
            child: CustomTextFormField(
              controller: titleController,
              label: 'عنوان الإشعار',
              hintText: titleHint,
              maxLines: 1,
              onSaved: (_) {},
            ),
          ),

          const SizedBox(height: 22),

          _buildField(
            context,
            icon: Icons.notes_outlined,
            label: 'محتوى الإشعار',
            child: CustomTextFormField(
              controller: bodyController,
              label: 'نص الإشعار',
              hintText: bodyHint,
              maxLines: 6,
              onSaved: (_) {},
            ),
          ),

          const SizedBox(height: 22),

          infoBox,

          const SizedBox(height: 20),

          sendButton,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColor.mainColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.edit_note_rounded,
            color: AppColor.textOnDark,
            size: 23,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionTitle,
                style: StyleManager.font16Weight700(context).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                sectionSubtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font11Weight400(context).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
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
            Icon(
              icon,
              color: AppColor.mainColor,
              size: 17,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: StyleManager.font12Weight500(context).copyWith(
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        child,
      ],
    );
  }
}