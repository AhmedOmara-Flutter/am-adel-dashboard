import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/style_manager.dart';

class NotificationsHubView extends StatelessWidget {
  const NotificationsHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),
              Text(
                'اختر نوع الإشعارات التي تريد متابعتها',
                style: StyleManager.font15Weight800(
                  context,
                ).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _NotificationTypeCard(
                        icon: Icons.campaign_rounded,
                        label: 'عام',
                        title: 'الإشعارات العامة',
                        subtitle: 'إشعارات المطعم للجميع',
                        description:
                        'تابع العروض، الإعلانات، الأخبار والتنبيهات التي يرسلها المطعم لجميع العملاء.',
                        accent: AppColor.accentColor,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteManager.sendNotification,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: _NotificationTypeCard(
                        icon: Icons.person_rounded,
                        label: 'خاص',
                        title: 'الإشعارات الخاصة',
                        subtitle: 'إشعاراتك الشخصية',
                        description:
                        'تابع إشعارات حسابك، تحديثات طلباتك وكل ما يخص تجربتك بشكل شخصي.',
                        accent: AppColor.green,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteManager.sendNotificationForEachUser,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String title;
  final String subtitle;
  final String description;
  final Color accent;
  final VoidCallback onTap;

  const _NotificationTypeCard({
    required this.icon,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: AppColor.divider,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryColor.withOpacity(.10),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(.10),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: accent.withOpacity(.18),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: accent,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(.09),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    label,
                    style: StyleManager.font12Weight500(
                      context,
                    ).copyWith(
                      color: accent,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColor.backgroundDark,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.divider,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.textSecondary,
                    size: 13,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 34,
              height: 3,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: StyleManager.font18Weight700(
                context,
              ).copyWith(
                color: AppColor.textPrimary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: StyleManager.font12Weight500(
                context,
              ).copyWith(
                color: accent,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font11Weight400(
                context,
              ).copyWith(
                color: AppColor.textSecondary,
                height: 1.5,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'عرض الإشعارات',
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(width: 7),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: accent,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}