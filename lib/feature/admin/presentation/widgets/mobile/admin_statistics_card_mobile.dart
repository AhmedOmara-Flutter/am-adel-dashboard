import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/statistics_card_model.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/icon_badge.dart';

class AdminStatisticsCardMobile extends StatelessWidget {
  final StatisticsCardModel model;

  const AdminStatisticsCardMobile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        height: model.height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(
            AppConstants.borderRadius,
          ),
          border: Border.all(
            color: AppColor.divider.withOpacity(.45),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(
                  icon: model.icon,
                  iconColor: model.iconColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: AppColor.textPrimary,
                      fontSize: responsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                      fontWeight: FontWeight.w700,
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
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(
                color: AppColor.mainColor,
                fontSize: responsiveFontSize(
                  context,
                  fontSize: 21,
                ),
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              model.subTitleText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font12Weight500(context).copyWith(
                color: AppColor.textSecondary,
                fontSize: responsiveFontSize(
                  context,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}