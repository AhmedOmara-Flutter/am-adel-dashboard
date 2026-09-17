import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../view_model/daily_reports_cubit.dart';
import '../widgets/daily_reports_view_body.dart';

class DailyReportView extends StatelessWidget {
  const DailyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const CustomBackButton(),
        ),
        centerTitle: true,
        title: Text(
          'جرد اليوم',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(
            color: AppColor.textOnDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      backgroundColor: AppColor.background,
      body: DailyReportsViewBody(),
    );
  }
}

