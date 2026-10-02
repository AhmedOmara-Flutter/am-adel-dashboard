import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';

class BuildDatePickerTile extends StatelessWidget {
  final String title;
  final DateTime? date;
  final VoidCallback onTap;

  const BuildDatePickerTile({
    super.key,
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.divider,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.goldLight.withOpacity(.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: AppColor.mainColor,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: StyleManager.font12Weight500(context).copyWith(
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    date == null
                        ? 'اختر التاريخ'
                        : '${date!.day}/${date!.month}/${date!.year}',
                    style: StyleManager.font11Weight400(context).copyWith(
                      color: date == null
                          ? AppColor.textSecondary
                          : AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
