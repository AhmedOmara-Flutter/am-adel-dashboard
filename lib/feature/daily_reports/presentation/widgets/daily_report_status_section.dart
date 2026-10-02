import 'package:flutter/material.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';

class DailyReportStatusSection extends StatelessWidget {
  const DailyReportStatusSection({super.key, required this.ordersCubit});

  final OrdersCubit ordersCubit;

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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.analytics_rounded,
                  color: AppColor.mainColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تفاصيل الطلبات',
                    style: TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'توزيع الطلبات حسب الحالة',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          DailyReportStatusRow(
            title: 'انتظار',
            count: _count(OrderStatus.pending),
            icon: Icons.hourglass_top_rounded,
            iconColor: Colors.orange,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'مؤكد',
            count: _count(OrderStatus.confirmed),
            icon: Icons.check_circle_outline_rounded,
            iconColor: Colors.blue,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'منتهي',
            count: _count(OrderStatus.delivered),
            icon: Icons.done_all_rounded,
            iconColor: Colors.green,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'مسدد',
            count: _count(OrderStatus.paid),
            icon: Icons.payments_outlined,
            iconColor: AppColor.mainColor,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'ملغي',
            count: _count(OrderStatus.cancelled),
            icon: Icons.cancel_outlined,
            iconColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  int _count(OrderStatus status) {
    return ordersCubit.allOrders
        .where((order) => order.status == status)
        .length;
  }
}

class DailyReportStatusRow extends StatelessWidget {
  const DailyReportStatusRow({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(.09),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, color: iconColor, size: 19),
        ),

        const SizedBox(width: 12),

        // Title
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.backgroundDark,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            '$count طلب',
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(color: AppColor.divider.withOpacity(.65), height: 1),
    );
  }
}
