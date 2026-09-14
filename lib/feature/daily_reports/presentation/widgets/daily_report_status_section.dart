import 'package:flutter/material.dart';

import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';

class DailyReportStatusSection extends StatelessWidget {
  const DailyReportStatusSection({
    super.key,
    required this.ordersCubit,
  });

  final OrdersCubit ordersCubit;

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'تفاصيل الطلبات',
      icon: Icons.analytics_outlined,
      child: Column(
        children: [
          DailyReportStatusRow(
            title: 'انتظار',
            count: _count(OrderStatus.pending),
            icon: Icons.hourglass_top_rounded,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'مؤكد',
            count: _count(OrderStatus.confirmed),
            icon: Icons.check_circle_outline_rounded,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'منتهي',
            count: _count(OrderStatus.delivered),
            icon: Icons.done_all_rounded,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'مسدد',
            count: _count(OrderStatus.paid),
            icon: Icons.payments_outlined,
          ),

          const _SectionDivider(),

          DailyReportStatusRow(
            title: 'ملغي',
            count: _count(OrderStatus.cancelled),
            icon: Icons.cancel_outlined,
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
  });

  final String title;
  final int count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.textSecondary,
          size: 19,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Text(
          '$count طلب',
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

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColor.mainColor,
                size: 21,
              ),

              const SizedBox(width: 9),

              Text(
                title,
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          child,
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
      ),
      child: Divider(
        color: AppColor.border,
        height: 1,
      ),
    );
  }
}