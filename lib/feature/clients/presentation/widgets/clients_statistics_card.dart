import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/statistics_card_model.dart';
import '../../../../core/utils/app_constants.dart';

class ClientsStatisticsCard extends StatelessWidget {
  final StatisticsCardModel model;

  const ClientsStatisticsCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withOpacity(AppConstants.borderColor),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(
            color: AppColor.divider.withOpacity(.55),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: model.height,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.backgroundDark,
                  child: Icon(
                    model.icon,
                    color: AppColor.mainColor,
                    size: responsiveFontSize(context, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    model.title,
                    style: StyleManager.font14Weight600(
                      context,
                    ).copyWith(color: AppColor.textPrimary),
                  ),
                ),
              ],
            ),

            const Spacer(),

            Text(
              model.subTitleNumber,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font19Weight700(context).copyWith(
                color: AppColor.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              model.subTitleText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font11Weight400(
                context,
              ).copyWith(color: AppColor.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
