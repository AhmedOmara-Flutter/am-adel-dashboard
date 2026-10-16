import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/selected_location_entity.dart';

class SelectedLocationCard extends StatelessWidget {
  const SelectedLocationCard({
    super.key,
    required this.location,
    required this.onEdit,
    required this.onDelete,
  });

  final SelectedLocationEntity location;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.mainColor.withOpacity(.14),
                  AppColor.accentColor.withOpacity(.08),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor.mainColor.withOpacity(.10)),
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: AppColor.mainColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font15Weight700(
                    context,
                  ).copyWith(color: AppColor.textPrimary),
                ),
                const SizedBox(height: 5),
                Text(
                  location.subTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(color: AppColor.textSecondary, height: 1.5),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(.055),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: AppColor.mainColor.withOpacity(.08),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delivery_dining_rounded,
                        size: 17,
                        color: AppColor.mainColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'رسوم التوصيل',
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(color: AppColor.textSecondary),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${location.cost.toStringAsFixed(0)} جنيه',
                        style: StyleManager.font12Weight500(context).copyWith(
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: AppColor.mainColor.withOpacity(.07),
                borderRadius: BorderRadius.circular(11),
                child: InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(11),
                  splashColor: AppColor.mainColor.withOpacity(.12),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: AppColor.red.withOpacity(.07),
                borderRadius: BorderRadius.circular(11),
                child: InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(11),
                  splashColor: AppColor.red.withOpacity(.12),
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: AppColor.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
