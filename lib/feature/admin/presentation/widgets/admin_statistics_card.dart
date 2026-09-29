import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/statistics_card_model.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/icon_badge.dart';

class AdminStatisticsCard extends StatelessWidget {
  final StatisticsCardModel model;

  const AdminStatisticsCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: model.onTap,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        child: Container(
          height: model.height,
          padding: const EdgeInsets.all(13),
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
                color: model.iconColor.withOpacity(.06),
                blurRadius: 18,
                spreadRadius: 1,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconBadge(
                    icon: model.icon,
                    iconColor: model.iconColor,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500(context).copyWith(
                        color: AppColor.textPrimary,
                        fontSize: responsiveFontSize(
                          context,
                          fontSize: 13,
                        ),
                        fontWeight: FontWeight.w800,
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
                  color: model.iconColor,
                  fontSize: responsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),

              const SizedBox(height: 8),

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
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}