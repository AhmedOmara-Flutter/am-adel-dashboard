import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';
import 'package:am_adel_dashboard/feature/daily_reports/presentation/widgets/reports_view_body.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_floating_action_button.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteManager.dailyReportView,
          );
        },
      ),      body: ReportsViewBody(),
    );
  }
}
