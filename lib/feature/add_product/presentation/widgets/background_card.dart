import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_container.dart';

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
    return CustomContainer(
      padding: context.isDesktop?EdgeInsets.zero:EdgeInsets.only(right: 15,top: 12,left: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding:context.isDesktop? const EdgeInsets.fromLTRB(
              16,
              14,
              16,
              13,
            ):EdgeInsets.zero,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 11),
                Icon(
                  icon,
                  size: 21,
                  color: AppColor.mainColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font16Weight700(
                          context,
                        ).copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          context.isDesktop?SizedBox(height: 0,):SizedBox(height: 15,),
          Container(
            height: 1,
            color: AppColor.divider.withOpacity(.28),
          ),
          child,
        ],
      ),
    );
  }
}
