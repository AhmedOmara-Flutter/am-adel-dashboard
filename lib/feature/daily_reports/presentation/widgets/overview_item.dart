import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class OverviewItem extends StatelessWidget {
  const OverviewItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: AppColor.background.withOpacity(.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.border.withOpacity(.20),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColor.mainColor,
            size: 16,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColor.mainColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}