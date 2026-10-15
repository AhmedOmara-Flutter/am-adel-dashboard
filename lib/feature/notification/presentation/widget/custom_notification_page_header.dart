import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';

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
    final isMobile =
        MediaQuery
            .sizeOf(context)
            .width <= ConfigSize.phone;

    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.09),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor.mainColor.withOpacity(.13)),
                ),
                child: Icon(
                  icon,
                  color: AppColor.mainColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font16Weight700(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font11Weight400(context).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (badgeText != null && !isMobile) ...[
                const SizedBox(width: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColor.mainColor.withOpacity(.13),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        badgeIcon ?? Icons.notifications_active_rounded,
                        color: AppColor.mainColor,
                        size: 17,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        badgeText!,
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (badgeText != null && isMobile) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.mainColor.withOpacity(.12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    badgeIcon ?? Icons.notifications_active_rounded,
                    color: AppColor.mainColor,
                    size: 16,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    badgeText!,
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColor.divider.withOpacity(.35),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font11Weight400(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_back_rounded,
                size: 17,
                color: AppColor.mainColor.withOpacity(.8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
