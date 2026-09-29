import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../core/services/print_service.dart';
import '../../../../core/utils/app_color.dart';
import '../../domain/entities/daily_reports_entity.dart';
import '../view_model/daily_reports_cubit.dart';
import 'details_value.dart';
import 'overview_item.dart';

class DailyReportCard extends StatelessWidget {
  const DailyReportCard({
    required this.report,
  });

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onDoubleTap: () {
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
                style: const TextStyle(
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
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColor.border.withOpacity(.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainColor.withOpacity(.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildHeader(),

                const SizedBox(height: 14),

                _buildOverview(),

                const SizedBox(height: 14),

                _buildSectionTitle(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'تفاصيل التسوية',
                ),

                const SizedBox(height: 8),

                _buildPaymentCard(
                  context: context,
                  icon: Icons.payments_outlined,
                  title: 'كاش',
                  subtotal: report.cashSubtotal,
                  delivery: report.cashDelivery,
                  total: report.cashTotal,
                ),

                const SizedBox(height: 8),

                _buildPaymentCard(
                  context: context,
                  icon: Icons.credit_card_rounded,
                  title: 'أونلاين',
                  subtotal: report.onlineSubtotal,
                  delivery: report.onlineDelivery,
                  total: report.onlineTotal,
                ),

                const SizedBox(height: 10),

                _buildTotalRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColor.accentColor.withOpacity(.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.receipt_long_rounded,
            color: AppColor.mainColor,
            size: 21,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'تقرير الجرد',
                    style: TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 7),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.accentColor.withOpacity(.14),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${report.ordersCount} طلب',
                      style: const TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                getDateFormate(report.date.toString()),
                style: TextStyle(
                  color: AppColor.textSecondary.withOpacity(.85),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          width: 38,
          height: 38,
          child: ElevatedButton(
            onPressed: () async {
              await PrintService.printDailyReport(report);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              backgroundColor: AppColor.mainColor,
              foregroundColor: AppColor.cardLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Icon(
              Icons.print_rounded,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverview() {
    return Row(
      children: [
        Expanded(
          child: OverviewItem(
            icon: Icons.shopping_bag_outlined,
            title: 'الطلبات',
            value: '${report.ordersCount}',
          ),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: OverviewItem(
            icon: Icons.delivery_dining_outlined,
            title: 'التوصيل',
            value: '${_formatPrice(report.deliveryCost)} ج',
          ),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: OverviewItem(
            icon: Icons.payments_outlined,
            title: 'بدون توصيل',
            value: '${_formatPrice(report.subtotal)} ج',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.mainColor,
          size: 16,
        ),

        const SizedBox(width: 6),

        Text(
          title,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required double subtotal,
    required double delivery,
    required double total,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: AppColor.accentColor.withOpacity(.06),
        highlightColor: AppColor.accentColor.withOpacity(.04),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.backgroundDark.withOpacity(.45),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.border.withOpacity(.25),
          ),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 2,
          ),

          childrenPadding: const EdgeInsets.fromLTRB(
            11,
            0,
            11,
            11,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          iconColor: AppColor.mainColor,
          collapsedIconColor: AppColor.textSecondary,

          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColor.accentColor.withOpacity(.14),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              color: AppColor.mainColor,
              size: 17,
            ),
          ),

          title: Text(
            title,
            style: const TextStyle(
              color: AppColor.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_formatPrice(total)} ج',
                style: const TextStyle(
                  color: AppColor.mainColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.mainColor,
                size: 19,
              ),
            ],
          ),

          children: [
            Container(
              height: 1,
              color: AppColor.divider.withOpacity(.65),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: DetailValue(
                    title: 'بدون توصيل',
                    value: subtotal,
                  ),
                ),

                Container(
                  width: 1,
                  height: 30,
                  color: AppColor.divider.withOpacity(.70),
                ),

                Expanded(
                  child: DetailValue(
                    title: 'التوصيل',
                    value: delivery,
                  ),
                ),

                Container(
                  width: 1,
                  height: 30,
                  color: AppColor.divider.withOpacity(.70),
                ),

                Expanded(
                  child: DetailValue(
                    title: 'بالتوصيل',
                    value: total,
                    highlight: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColor.accentColor.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.accentColor.withOpacity(.30),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColor.accentColor.withOpacity(.16),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColor.mainColor,
              size: 18,
            ),
          ),

          const SizedBox(width: 9),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إجمالي اليوم',
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  'كاش + أونلاين شامل التوصيل',
                  style: TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),

          Text(
            '${_formatPrice(report.total)} ج',
            style: const TextStyle(
              color: AppColor.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    if (price == price.roundToDouble()) {
      return price.toInt().toString();
    }

    return price.toStringAsFixed(2);
  }
}