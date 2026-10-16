import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/daily_reports_view_body.dart';

class DailyReportView extends StatelessWidget {
  const DailyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(
      title: 'جرد اليوم',
      buttonType: AppBarButtonType.back,
    ),

      backgroundColor: AppColor.background,
      body: DailyReportsViewBody(),
    );
  }
}

