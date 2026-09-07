import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class CustomerInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CustomerInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColor.mainColor,
              size: 20,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font13Weight600(context).copyWith(
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  subtitle,
                  style: StyleManager.font11Weight400(context).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}