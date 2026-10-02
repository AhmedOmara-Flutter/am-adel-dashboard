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
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColor.mainColor,
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الحساب النهائي',
                    style: TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'ملخص الحسابات اليومية',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 22),

          _MoneyRow(
            title: 'صافي المبيعات',
            value: report.subtotal,
            icon: Icons.shopping_bag_outlined,
          ),

          const SizedBox(height: 13),

          _MoneyRow(
            title: 'الدليفري',
            value: report.deliveryCost,
            icon: Icons.delivery_dining_rounded,
          ),

          const SizedBox(height: 13),

          _MoneyRow(
            title: 'الكاش',
            value: report.cashTotal,
            icon: Icons.payments_outlined,
          ),

          const SizedBox(height: 13),

          _MoneyRow(
            title: 'Online',
            value: report.onlineTotal,
            icon: Icons.credit_card_rounded,
          ),

          const SizedBox(height: 20),

          // Total
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColor.mainColor.withOpacity(.12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إجمالي اليوم',
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'إجمالي المبلغ المسدد',
                        style: TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  '${report.total.toStringAsFixed(2)} ج.م',
                  style: TextStyle(
                    color: AppColor.mainColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
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

class _MoneyRow extends StatelessWidget {
  const _MoneyRow({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final double value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColor.backgroundDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColor.textSecondary, size: 17),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Text(
          '${value.toStringAsFixed(2)} ج.م',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
