
import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/daily_reports_entity.dart';
import 'daily_report_stat_card.dart';

class DailyReportStats extends StatelessWidget {
  const DailyReportStats({
    super.key,
    required this.report,
  });

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    final cards = [
      DailyReportStatCard(
        title: 'الطلبات المسددة',
        value: '${report.ordersCount}',
        subtitle: 'طلب',
        icon: Icons.receipt_long_rounded,
      ),
      DailyReportStatCard(
        title: 'مسدد كاش',
        value: _formatMoney(report.cashTotal),
        subtitle: 'ج.م',
        icon: Icons.payments_rounded,
      ),
      DailyReportStatCard(
        title: 'مسدد أونلاين',
        value: _formatMoney(report.onlineTotal),
        subtitle: 'ج.م',
        icon: Icons.credit_card_rounded,
      ),
      DailyReportStatCard(
        title: 'إجمالي اليوم',
        value: _formatMoney(report.total),
        subtitle: 'ج.م',
        icon: Icons.account_balance_wallet_rounded,
        isTotal: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = context.isDesktop ? 4 : 2;
        const spacing = 10.0;

        final cardWidth =
            (constraints.maxWidth -
                (spacing * (crossAxisCount - 1))) /
                crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards.map((card) {
            return SizedBox(
              width: cardWidth,
              child: card,
            );
          }).toList(),
        );
      },
    );
  }

  String _formatMoney(double value) {
    return value.toStringAsFixed(2);
  }
}
