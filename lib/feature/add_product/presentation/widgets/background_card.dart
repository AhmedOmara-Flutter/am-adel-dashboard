import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';

class BackgroundCard extends StatelessWidget {
  final Widget child;
  final String label;
  final String subLabel;
  final IconData icon;

  const BackgroundCard({
    super.key,
    required this.child,
    required this.label,
    required this.subLabel,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        10,
      ),
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
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: Border.all(
                color: AppColor.border,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppColor.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subLabel,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}