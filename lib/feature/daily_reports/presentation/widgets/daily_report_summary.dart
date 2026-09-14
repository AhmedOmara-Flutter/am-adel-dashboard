import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/daily_reports_entity.dart';

class DailyReportSummary extends StatelessWidget {
  const DailyReportSummary({super.key, required this.report});

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.mainColor.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColor.mainColor,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'الحساب النهائي',
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _MoneyRow(title: 'صافي المبيعات', value: report.subtotal),
          const SizedBox(height: 12),
          _MoneyRow(title: 'الدليفري', value: report.deliveryCost),
          const SizedBox(height: 12),
          _MoneyRow(title: 'الكاش', value: report.cashTotal),
          const SizedBox(height: 12),
          _MoneyRow(title: 'Online', value: report.onlineTotal),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColor.border, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي اليوم',
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${report.total.toStringAsFixed(2)} ج.م',
                style: TextStyle(
                  color: AppColor.mainColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  const _MoneyRow({required this.title, required this.value});

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${value.toStringAsFixed(2)} ج.م',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
