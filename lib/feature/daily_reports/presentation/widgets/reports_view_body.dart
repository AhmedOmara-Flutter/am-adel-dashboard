import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/daily_reports/domain/entities/daily_reports_entity.dart';
import 'package:am_adel_dashboard/feature/daily_reports/presentation/view_model/daily_reports_cubit.dart';

import '../../../../core/helper_function/custom_show_dialog.dart';

class ReportsViewBody extends StatefulWidget {
  const ReportsViewBody({super.key});

  @override
  State<ReportsViewBody> createState() => _ReportsViewBodyState();
}

class _ReportsViewBodyState extends State<ReportsViewBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<DailyReportsCubit>();

      if (cubit.reports.isEmpty) {
        cubit.getDailyReports();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyReportsCubit, DailyReportsState>(
      builder: (context, state) {
        final cubit = context.read<DailyReportsCubit>();

        final reports = state is DailyReportsSuccess
            ? state.reports
            : cubit.reports;

        if (reports.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: reports.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              return _DailyReportCard(
                report: reports[index],
              );
            },
          );
        }

        if (state is DailyReportsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.mainColor,
            ),
          );
        }

        if (state is DailyReportsError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Center(
          child: Text(
            'لا توجد تقارير محفوظة',
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }
}

class _DailyReportCard extends StatelessWidget {
  const _DailyReportCard({
    required this.report,
  });

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onLongPress: () {
            CustomShowDialog.show(
              context,
              title: 'حذف تقرير الجرد',
              flag: Icons.delete_outline_rounded,
              acceptText: 'حذف',
              cancelText: 'إلغاء',
              content: Text(
                'هل أنت متأكد من حذف تقرير الجرد؟\n\n'
                    'سيتم حذف التقرير نهائيًا ولا يمكن التراجع عن هذا الإجراء.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              accept: () async {
                Navigator.pop(context);

                await context
                    .read<DailyReportsCubit>()
                    .deleteDailyReport(report.id!);
              },);
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColor.mainColor.withOpacity(.15),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withOpacity(.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.receipt_long_rounded,
                        color: AppColor.mainColor,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'تقرير الجرد',
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getDateFormate(report.date.toString()),
                            style: const TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'الإجمالي',
                          style: TextStyle(
                            color: AppColor.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${_formatPrice(report.total)} ج',
                          style: const TextStyle(
                            color: AppColor.mainColor,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  height: 1,
                  color: AppColor.white.withOpacity(.06),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _ReportItem(
                        icon: Icons.shopping_bag_outlined,
                        title: 'الطلبات',
                        value: '${report.ordersCount}',
                      ),
                    ),
                    Expanded(
                      child: _ReportItem(
                        icon: Icons.payments_outlined,
                        title: 'كاش',
                        value: '${_formatPrice(report.cashTotal)} ج',
                      ),
                    ),
                    Expanded(
                      child: _ReportItem(
                        icon: Icons.credit_card_rounded,
                        title: 'أونلاين',
                        value: '${_formatPrice(report.onlineTotal)} ج',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColor.mainColor.withOpacity(.10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColor.mainColor.withOpacity(.12),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                color: AppColor.mainColor,
                                size: 19,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'بدون التوصيل',
                                    style: TextStyle(
                                      color: AppColor.textSecondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_formatPrice(report.subtotal)} ج',
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColor.mainColor.withOpacity(.10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColor.mainColor.withOpacity(.12),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: const Icon(
                                Icons.delivery_dining_rounded,
                                color: AppColor.mainColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'التوصيل',
                                    style: TextStyle(
                                      color: AppColor.textSecondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_formatPrice(report.deliveryCost)} ج',
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatPrice(double price) {
    if (price == price.roundToDouble()) {
      return price.toInt().toString();
    }

    return price.toStringAsFixed(2);
  }
}

class _ReportItem extends StatelessWidget {
  const _ReportItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColor.mainColor,
          size: 20,
        ),
        const SizedBox(height: 7),
        Text(
          title,
          style: const TextStyle(
            color: AppColor.textSecondary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColor.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}