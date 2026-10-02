import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/services/print_service.dart';
import 'package:am_adel_dashboard/feature/daily_reports/domain/entities/daily_reports_entity.dart';
import 'package:am_adel_dashboard/feature/daily_reports/presentation/view_model/daily_reports_cubit.dart';

import '../../../../core/helper_function/custom_show_dialog.dart';
import 'daily_report_card.dart';

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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 100),
            itemCount: reports.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return DailyReportCard(report: reports[index]);
            },
          );
        }

        if (state is DailyReportsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        }

        if (state is DailyReportsError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColor.red, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Center(
          child: Text(
            'لا توجد تقارير محفوظة',
            style: StyleManager.font14Weight600(context).copyWith(
                color: AppColor.textSecondary
            ),
          ),
        );
      },
    );
  }
}
