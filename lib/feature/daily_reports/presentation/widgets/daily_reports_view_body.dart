import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_color.dart';
import '../view_model/daily_reports_cubit.dart';
import 'daily_report_actions.dart';
import 'daily_report_header.dart';
import 'daily_report_stats.dart';
import 'daily_report_status_section.dart';
import 'daily_report_summary.dart';

class DailyReportsViewBody extends StatefulWidget {
  const DailyReportsViewBody({super.key});

  @override
  State<DailyReportsViewBody> createState() => _DailyReportsViewBodyState();
}

class _DailyReportsViewBodyState extends State<DailyReportsViewBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DailyReportsCubit>().calculateTodayReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyReportsCubit, DailyReportsState>(
      builder: (context, state) {
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
              style: TextStyle(
                color: AppColor.textPrimary,
              ),
            ),
          );
        }

        final cubit = context.read<DailyReportsCubit>();
        final report = cubit.report;

        if (report == null) {
          return Center(
            child: Text(
              'لا توجد بيانات للجرد',
              style: TextStyle(
                color: AppColor.textSecondary,
                fontSize: 15,
              ),
            ),
          );
        }

        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const DailyReportHeader(),
                    const SizedBox(height: 18),
                    DailyReportStats(report: report),
                    const SizedBox(height: 18),
                    DailyReportStatusSection(
                      ordersCubit: cubit.ordersCubit,
                    ),
                    const SizedBox(height: 18),
                    DailyReportSummary(report: report),
                    const SizedBox(height: 24),
                    DailyReportActions(report: report),
                  ],
                ),
              ),
            ),

            if (state is DailyReportsClosing)
              Positioned.fill(
                child: Container(
                  color: AppColor.black.withOpacity(0.25),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}