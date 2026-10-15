import 'package:flutter/material.dart';
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
    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(isTotal ? .14 : .07),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColor.mainColor.withOpacity(isTotal ? .18 : .08),
                  ),
                ),
                child: Icon(icon, size: 22, color: AppColor.mainColor),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 18),
          Container(
            height: 3,
            width: isTotal ? 42 : 26,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(isTotal ? 1 : .45),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
