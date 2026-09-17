import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/make_call_function.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';

class CustomerInfoSection extends StatelessWidget {
  const CustomerInfoSection({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final user = order.userEntity!;

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
            'بيانات العميل',
            style: StyleManager.font13Weight600(context).copyWith(
              color: AppColor.textPrimary,
            ),
          ),

          SizedBox(height: 12),

          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.backgroundDark,
                backgroundImage: AssetImage(
                  Assets.assets.images.customer.path,
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makeFullName(user.userName),
                      style: StyleManager.font15Weight700(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      user.email,
                      style: StyleManager.font12Weight500(context).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 14),

          _InfoTile(
            icon: Icons.phone_rounded,
            title: 'رقم الهاتف',
            value: user.phone,
            onTap: () => makePhoneCall(user.phone),
          ),

          SizedBox(height: 10),

          _InfoTile(
            icon: Icons.person_outline_rounded,
            title: 'اسم المستلم',
            value: order.addressEntity!.name,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
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
                size: 17,
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
                    style: StyleManager.font13Weight600(context).copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}