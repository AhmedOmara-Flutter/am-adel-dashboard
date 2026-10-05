import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/selected_location_entity.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';

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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.32)),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _LocationIcon(),
          const SizedBox(width: 12),
          Expanded(child: _LocationInfo(location: location)),
          const SizedBox(width: 12),
          _Actions(onEdit: onEdit, onDelete: onDelete),
        ],
      ),
    );
  }
}

class _LocationIcon extends StatelessWidget {
  const _LocationIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: AppColor.mainColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(13),
      ),
      child: const Icon(
        Icons.location_on_rounded,
        color: AppColor.mainColor,
        size: 22,
      ),
    );
  }
}

class _LocationInfo extends StatelessWidget {
  final SelectedLocationEntity location;

  const _LocationInfo({required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 3),
        Text(
          location.subTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font12Weight500(
            context,
          ).copyWith(color: AppColor.textSecondary),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Icon(
              Icons.delivery_dining_outlined,
              size: 15,
              color: AppColor.mainColor.withOpacity(.8),
            ),
            const SizedBox(width: 5),
            Text(
              'رسوم التوصيل',
              style: StyleManager.font11Weight400(
                context,
              ).copyWith(color: AppColor.textSecondary),
            ),
            const SizedBox(width: 7),
            Text(
              '${location.cost.toStringAsFixed(0)} جنيه',
              style: StyleManager.font12Weight500(
                context,
              ).copyWith(color: AppColor.mainColor),
            ),
          ],
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _Actions({required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionButton(
          icon: Icons.edit_outlined,
          color: AppColor.mainColor,
          onTap: onEdit,
        ),
        const SizedBox(width: 6),
        _ActionButton(
          icon: Icons.delete_outline_rounded,
          color: AppColor.red,
          onTap: onDelete,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(.07),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}
