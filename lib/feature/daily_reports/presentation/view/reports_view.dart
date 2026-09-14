import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';
import 'package:am_adel_dashboard/feature/daily_reports/presentation/widgets/reports_view_body.dart';

import '../../../../core/utils/app_color.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton(
              heroTag: null,
              backgroundColor: AppColor.mainColor,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.pushNamed(context, RouteManager.dailyReportView);
              },
              child: const Icon(Icons.add, color: AppColor.white),
            ),
          ],
        ),
      ),
      body: ReportsViewBody(),
    );
  }
}
