import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_back_button.dart';
import '../widget/send_notification_for_each_user_body.dart';

class SendNotificationForEachUser extends StatefulWidget {
  const SendNotificationForEachUser({super.key});

  @override
  State<SendNotificationForEachUser> createState() =>
      _SendNotificationForEachUserState();
}

class _SendNotificationForEachUserState
    extends State<SendNotificationForEachUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const CustomBackButton(),
        ),
        centerTitle: true,
        title: Text(
          'الاشعارات المخصصه',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: AppColor.textOnDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SendNotificationForEachUserBody(),
    );
  }
}
