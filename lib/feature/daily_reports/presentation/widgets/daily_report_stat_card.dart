
import 'package:flutter/material.dart';
import '../../../../core/extension/responsive_extension.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';

class DailyReportStatCard extends StatelessWidget {
  const DailyReportStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    this.isTotal = false,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final bool isTotal;


  @override
  Widget build(BuildContext context) {
    final isPhone = context.isPhone;
    final isTablet = context.isTablet;

    final padding = isPhone ? 14.0 : isTablet ? 18.0 : 22.0;
    final iconSize = isPhone ? 32.0 : isTablet ? 40.0 : 44.0;
    final valueFontSize = isPhone ? 18.0 : isTablet ? 23.0 : 25.0;

    return CustomContainer(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textSecondary,
                    fontSize: isPhone ? 11 : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withValues(
                    alpha: isTotal ? 0.14 : 0.07,
                  ),
                  borderRadius: BorderRadius.circular(isPhone ? 9 : 14),
                ),
                child: Icon(
                  icon,
                  size: isPhone ? 17 : 22,
                  color: AppColor.mainColor,
                ),
              ),
            ],
          ),
          SizedBox(height: isPhone ? 14 : 22),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: valueFontSize,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.textSecondary,
                fontSize: isPhone ? 10 : 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          SizedBox(height: isPhone ? 12 : 18),
          Container(
            height: 3,
            width: isTotal ? 42 : 26,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withValues(
                alpha: isTotal ? 1 : 0.45,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
