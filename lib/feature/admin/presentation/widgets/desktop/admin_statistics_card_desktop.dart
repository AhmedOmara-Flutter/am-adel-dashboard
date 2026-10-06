import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/statistics_card_model.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/icon_badge.dart';

class AdminStatisticsCardDesktop extends StatelessWidget {
  final StatisticsCardModel model;

  const AdminStatisticsCardDesktop({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        height: model.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(
            AppConstants.borderRadius,
          ),
          border: Border.all(
            color: AppColor.border.withOpacity(.40),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.accentColor.withOpacity(.06),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 7),
            ),
          ],
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
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font12Weight500(context).copyWith(
                      color: AppColor.textPrimary,
                      fontSize: responsiveFontSize(
                        context,
                        fontSize: 11,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.subTitleNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font18Weight700(context).copyWith(
                    color: AppColor.mainColor,
                    fontSize: responsiveFontSize(
                      context,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  model.subTitleText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font11Weight400(context).copyWith(
                    color: AppColor.textSecondary.withOpacity(.80),
                    fontSize: responsiveFontSize(
                      context,
                      fontSize: 9,
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}