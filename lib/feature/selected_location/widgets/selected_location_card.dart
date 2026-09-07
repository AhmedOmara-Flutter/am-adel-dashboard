import 'package:flutter/material.dart';

import '../../../core/entities/selected_location_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: AppColor.mainColor,
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
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
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  location.subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font13Weight600(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.accentColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.delivery_dining_rounded,
                        color: AppColor.accentColor,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${location.cost.toStringAsFixed(0)} جنيه',
                        style: StyleManager.font13Weight600(
                          context,
                        ).copyWith(
                          color: AppColor.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: AppColor.mainColor.withOpacity(.10),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(8),
                  child: const SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(
                      Icons.edit_outlined,
                      color: AppColor.mainColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Material(
                color: AppColor.red.withOpacity(.10),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(8),
                  child: const SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColor.red,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),        ],
      ),
    );
  }
}