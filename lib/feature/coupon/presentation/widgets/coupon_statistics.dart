import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/config_size.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/coupon_entity.dart';

class CouponStatistics extends StatelessWidget {
  final List<CouponEntity> coupons;

  const CouponStatistics({super.key, required this.coupons});

  @override
  Widget build(BuildContext context) {
    final activeCoupons = coupons.where((coupon) {
      return !DateTime.now().isAfter(coupon.expiresAt);
    }).length;

    final expiredCoupons = coupons.where((coupon) {
      return DateTime.now().isAfter(coupon.expiresAt);
    }).length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatisticCard(
                context,
                title: 'إجمالي الكوبونات',
                value: '${coupons.length}',
                subTitle: 'جميع الكوبونات',
                icon: Icons.confirmation_number_outlined,
                color: AppColor.mainColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildStatisticCard(
                context,
                title: 'الكوبونات النشطة',
                value: '$activeCoupons',
                subTitle: 'الكوبونات المتاحة',
                icon: Icons.check_circle_outline,
                color: AppColor.accentColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatisticCard(
                context,
                title: 'الكوبونات المنتهية',
                value: '$expiredCoupons',
                subTitle: 'الكوبونات المنتهية',
                icon: Icons.timer_off_outlined,
                color: AppColor.secondaryColor,
              ),
            ),

          ],
        ),
      ],
    );
  }

  Widget _buildStatisticCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subTitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: MediaQuery.sizeOf(context).width > ConfigSize.phone ? 170 : 145,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.10),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: AppColor.divider.withOpacity(.55), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(.12),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: StyleManager.font14Weight600(
              context,
            ).copyWith(color: AppColor.textPrimary),
          ),
          const Spacer(),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font19Weight700(
              context,
            ).copyWith(color: AppColor.mainColor),
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(color: AppColor.textSecondary),
          ),
        ],
      ),
    );
  }
}
