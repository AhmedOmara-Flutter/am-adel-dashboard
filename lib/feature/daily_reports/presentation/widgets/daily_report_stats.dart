import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/daily_reports_entity.dart';

class DailyReportStats extends StatelessWidget {
  const DailyReportStats({
    super.key,
    required this.report,
  });

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.55,
      children: [
        DailyReportStatCard(
          title: 'الطلبات المسددة',
          value: '${report.ordersCount}',
          subtitle: 'طلب',
          icon: Icons.receipt_long_rounded,
        ),
        DailyReportStatCard(
          title: 'الكاش',
          value: _formatMoney(report.cashTotal),
          subtitle: 'ج.م',
          icon: Icons.payments_rounded,
        ),
        DailyReportStatCard(
          title: 'اونلاين',
          value: _formatMoney(report.onlineTotal),
          subtitle: 'ج.م',
          icon: Icons.credit_card_rounded,
        ),
        DailyReportStatCard(
          title: 'إجمالي اليوم',
          value: _formatMoney(report.total),
          subtitle: 'ج.م',
          icon: Icons.account_balance_wallet_rounded,
        ),
      ],
    );
  }

  String _formatMoney(double value) {
    return value.toStringAsFixed(2);
  }
}

class DailyReportStatCard extends StatelessWidget {
  const DailyReportStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColor.mainColor,
              size: 21,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}