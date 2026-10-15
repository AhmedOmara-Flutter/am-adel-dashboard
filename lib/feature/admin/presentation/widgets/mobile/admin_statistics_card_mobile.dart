import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/statistics_card_model.dart';
import '../../../../../core/widgets/icon_badge.dart';
import '../../../../../core/widgets/custom_container.dart';

class AdminStatisticsCardMobile extends StatelessWidget {
  final StatisticsCardModel model;

  const AdminStatisticsCardMobile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: model.height,
      onTap: model.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(
                icon: model.icon,
                iconColor: AppColor.textSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.black,
                    fontSize: responsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            model.subTitleNumber,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColor.textPrimary,
              fontSize: responsiveFontSize(
                context,
                fontSize: 21,
              ),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            model.subTitleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font12Weight500(context).copyWith(
              color: AppColor.textSecondary.withOpacity(0.8),
              fontSize: responsiveFontSize(
                context,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}