import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/config_size.dart';

class StatisticsCard extends StatelessWidget {
  final StatisticsCardModel model;

  const StatisticsCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        margin:MediaQuery.sizeOf(context).width > ConfigSize.phone? EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
            right: 10
        ):EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withOpacity(AppConstants.borderColor),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border(
            bottom: BorderSide(color: AppColor.border),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height:MediaQuery.sizeOf(context).width > ConfigSize.phone?150: 125,
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Header
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: model.color.withOpacity(.12),
                  child: Icon(
                    model.icon,
                    color: model.color,
                    size: responsiveFontSize(
                      context,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: responsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            /// Number
            Text(
              model.subTitleNumber,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: responsiveFontSize(
                  context,
                  fontSize: 22,
                ),
              ),
            ),

            SizedBox(height: 15),

            /// Description
            Text(
              model.subTitleText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font12Weight500(context).copyWith(
                color: AppColor.textSecondary,
                fontSize: responsiveFontSize(
                  context,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsCardModel {
  final Color color;
  final IconData icon;
  final String title;
  final String subTitleNumber;
  final String subTitleText;
  final VoidCallback? onTap;

  StatisticsCardModel({
    required this.color,
    required this.icon,
    required this.title,
    required this.subTitleNumber,
    required this.subTitleText,
    this.onTap,
  });
}