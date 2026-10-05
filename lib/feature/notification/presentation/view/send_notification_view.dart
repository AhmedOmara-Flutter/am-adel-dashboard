import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

import '../widget/send_notification_view_body.dart';

class SendNotificationView extends StatelessWidget {
  const SendNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: CustomBackButton(),
        ),
        centerTitle: true,
        title: Text(
          'الاشعارات العامه',
          style: StyleManager.font18Weight700(
            context,
          ).copyWith(color: AppColor.textOnDark),
        ),
      ),
      body: SendNotificationViewBody(),
    );
  }
}
