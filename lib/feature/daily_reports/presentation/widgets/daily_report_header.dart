import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_back_button.dart';

class DailyReportHeader extends StatelessWidget {
  const DailyReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadius,
            ),
            border: Border.all(
              color: AppColor.divider,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.backgroundDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: AppColor.mainColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'جرد اليوم',
                      style: TextStyle(
                        color: AppColor.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      getDateFormate(DateTime.now().toString()),
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}