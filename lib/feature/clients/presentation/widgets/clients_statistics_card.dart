import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/statistics_card_model.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_container.dart';

class ClientsStatisticsCard extends StatelessWidget {
  final StatisticsCardModel model;

  const ClientsStatisticsCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: CustomContainer(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: model.height,
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
