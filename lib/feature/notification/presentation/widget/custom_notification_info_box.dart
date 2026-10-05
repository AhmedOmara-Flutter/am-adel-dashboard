import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';


class CustomNotificationInfoBox extends StatelessWidget {
  const CustomNotificationInfoBox({
    super.key,
    required this.title,
    required this.description,
    this.badgeText,
    this.icon = Icons.campaign_rounded,
    this.showStatus = true,
  });

  final String title;
  final String description;
  final String? badgeText;
  final IconData icon;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.border.withOpacity(.25),
        ),
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 13),
          Expanded(
            child: _buildContent(context),
          ),
          if (showStatus) ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.check_circle_rounded,
              color: AppColor.green,
              size: 20,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColor.mainColor,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: AppColor.textOnDark,
        size: 21,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font13Weight600(context).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ),
            if (badgeText != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColor.green.withOpacity(.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText!,
                  style: StyleManager.font11Weight400(context).copyWith(
                    color: AppColor.green,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: StyleManager.font11Weight400(context).copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}