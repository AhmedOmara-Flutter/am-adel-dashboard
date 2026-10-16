import 'package:flutter/material.dart';

import '../../../../core/extension/responsive_extension.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../domain/entities/daily_reports_entity.dart';

class DailyReportSummary extends StatelessWidget {
  const DailyReportSummary({super.key, required this.report});

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    final items = [
      _ReportItem(
        title: 'صافي المبيعات',
        value: report.subtotal,
        color: AppColor.mainColor,
      ),
      _ReportItem(
        title: 'الدليفري',
        value: report.deliveryCost,
        color: const Color(0xFFF5A623),
      ),
      _ReportItem(
        title: 'الكاش',
        value: report.cashTotal,
        color: const Color(0xFF20B486),
      ),
      _ReportItem(
        title: 'Online',
        value: report.onlineTotal,
        color: const Color(0xFF4388F5),
      ),
    ];

    return CustomContainer(
      width: double.infinity,
      padding: EdgeInsets.all(context.isDesktop?22:17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'الحساب النهائي',
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'ملخص يومي',
                style: TextStyle(color: AppColor.textSecondary, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'إجمالي اليوم',
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    report.total.toStringAsFixed(2),
                    style: TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ج.م',
                style: TextStyle(
                  color: AppColor.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(height: 1, color: AppColor.border.withOpacity(.4)),
          const SizedBox(height: 4),
          ...List.generate(items.length, (index) {
            final item = items[index];

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 3,
                        height: 24,
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: AppColor.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item.value.toStringAsFixed(2),
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'ج.م',
                        style: TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index != items.length - 1)
                  Container(height: 1, color: AppColor.border.withOpacity(.22)),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ReportItem {
  const _ReportItem({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final double value;
  final Color color;
}
