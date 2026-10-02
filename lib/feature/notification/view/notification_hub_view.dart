import 'package:am_adel_dashboard/core/utils/route_manager.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/style_manager.dart';
import '../widget/notification_type_card.dart';

class NotificationsHubView extends StatelessWidget {
  const NotificationsHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColor.accentColor.withOpacity(.10),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.notifications_active_outlined,
                          color: AppColor.accentColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'نوع الإشعارات',
                        style: StyleManager.font16Weight700(
                          context,
                        ).copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 44),
                    child: Text(
                      'اختر القسم الذي تريد إدارته ومتابعة إشعاراته',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColor.divider.withOpacity(.7),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 10),
                  children: [
                    NotificationTypeCard(
                      icon: Icons.campaign_rounded,
                      label: 'عام',
                      title: 'الإشعارات العامة',
                      subtitle: 'لجميع العملاء',
                      description:
                      'العروض والإعلانات والأخبار والتنبيهات التي تظهر لجميع العملاء.',
                      accent: AppColor.accentColor,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManager.sendNotification,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    NotificationTypeCard(
                      icon: Icons.person_rounded,
                      label: 'خاص',
                      title: 'الإشعارات الخاصة',
                      subtitle: 'لعملاء محددين',
                      description:
                      'إرسال ومتابعة الإشعارات المرتبطة بحساب عميل أو طلب محدد.',
                      accent: AppColor.green,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManager.sendNotificationForEachUser,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

