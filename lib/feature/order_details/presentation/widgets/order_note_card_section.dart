import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

class OrderNoteCardSection extends StatelessWidget {
  const OrderNoteCardSection({
    super.key,
    required this.note,
  });

  final String? note;

  @override
  Widget build(BuildContext context) {
    if (note == null || note!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.divider,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sticky_note_2_outlined,
              color: AppColor.mainColor,
              size: 16,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ملاحظات الطلب',
                  style: StyleManager.font13Weight600(context).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  note!,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}