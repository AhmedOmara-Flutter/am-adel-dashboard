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
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                color: AppColor.mainColor,
                size: 22,
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    date == null
                        ? 'اختر التاريخ'
                        : '${date!.day}/${date!.month}/${date!.year}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
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