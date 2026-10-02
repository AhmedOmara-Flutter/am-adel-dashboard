import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

class OrderNoteCardSection extends StatelessWidget {
  const OrderNoteCardSection({
    super.key,
    required this.note,
  });

  final String? note;

  @override
  Widget build(BuildContext context) {
    final value = note?.trim();

    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider.withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.sticky_note_2_outlined,
                size: 19,
                color: AppColor.mainColor,
              ),
              const SizedBox(width: 9),
              Text(
                'ملاحظات الطلب',
                style: StyleManager.font13Weight600(
                  context,
                ).copyWith(
                  color: AppColor.textPrimary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
            decoration: BoxDecoration(
              color: AppColor.background.withOpacity(.55),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text(
              value,
              style: StyleManager.font12Weight500(
                context,
              ).copyWith(
                color: AppColor.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
