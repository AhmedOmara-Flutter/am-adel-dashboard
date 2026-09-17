import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final address = order.addressEntity!;
    final location = order.selectedLocationEntity!;

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'عنوان التوصيل',
            style: StyleManager.font13Weight600(context).copyWith(
              color: AppColor.textPrimary,
            ),
          ),

          SizedBox(height: 12),

          _AddressTile(
            icon: Icons.map_outlined,
            title: 'المنطقة',
            value: location.title,
          ),

          SizedBox(height: 8),

          _AddressTile(
            icon: Icons.location_on_outlined,
            title: 'العنوان',
            value: address.address,
          ),
        ],
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
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
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.divider,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColor.mainColor,
              size: 16,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: StyleManager.font11Weight400(context).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  value,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textPrimary,
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