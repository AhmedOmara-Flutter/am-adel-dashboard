import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class CustomerStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const CustomerStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: AppColor.mainColor,
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            height: 20,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: StyleManager.font12Weight500(
                  context,
                ).copyWith(
                  color: AppColor.textPrimary,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(
              color: AppColor.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}