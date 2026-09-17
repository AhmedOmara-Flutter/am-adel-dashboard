import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/services/print_service.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/daily_reports_entity.dart';
import '../view_model/daily_reports_cubit.dart';

class DailyReportActions extends StatelessWidget {
  const DailyReportActions({
    super.key,
    required this.report,
  });

  final DailyReportEntity report;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {
          CustomShowDialog.show(
            context,
            title: 'إتمام جرد اليوم',
            flag: Icons.lock_outline_rounded,
            acceptText: 'إتمام الجرد',
            cancelText: 'إلغاء',
            content: Text(
              'هل أنت متأكد من إتمام جرد اليوم؟\n\n'
                  'سيتم حفظ الجرد أولاً، وبعد نجاح الحفظ سيتم إنهاء طلبات اليوم.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            accept: () async {
              Navigator.pop(context);

              final cubit = context.read<DailyReportsCubit>();

              await cubit.closeToday();

              if (!context.mounted) return;

              if (cubit.state is DailyReportsClosed) {
                Navigator.pop(context);
              }
            },
          );
        },
        icon: const Icon(
          Icons.lock_outline_rounded,
        ),
        label: const Text(
          'إتمام جرد اليوم',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.mainColor,
          foregroundColor: AppColor.textOnDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadius,
            ),
          ),
        ),
      ),
    );
  }
}