import 'package:flutter/material.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/config_size.dart';
import '../../../core/utils/style_manager.dart';

class CustomNotificationPageHeader extends StatelessWidget {
  const CustomNotificationPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.badgeText,
    this.badgeIcon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? badgeText;
  final IconData? badgeIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColor.border.withOpacity(.28),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainColor.withOpacity(.18),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColor.textOnDark,
              size: 29,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: StyleManager.font19Weight700(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (badgeText != null &&
              MediaQuery.sizeOf(context).width > ConfigSize.phone)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.mainColor.withOpacity(.14),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    badgeIcon ?? Icons.notifications_rounded,
                    color: AppColor.mainColor,
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    badgeText!,
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}