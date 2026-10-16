import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
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
        appBar: const CustomAppBar(
          title: 'الاشعارات المخصصه',
          buttonType: AppBarButtonType.back,
        ),
      body: SendNotificationForEachUserBody(),
    );
  }
}
