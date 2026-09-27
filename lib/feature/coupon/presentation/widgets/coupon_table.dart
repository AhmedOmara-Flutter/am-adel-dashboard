import 'dart:async';

import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_coupon_entity.dart';

class CouponTable extends StatefulWidget {
  final List<UserCouponEntity> coupons;
  final Function(UserCouponEntity) onDelete;
  final String Function(DateTime) getDateFormate;

  const CouponTable({
    super.key,
    required this.coupons,
    required this.onDelete,
    required this.getDateFormate,
  });

  @override
  State<CouponTable> createState() => _CouponTableState();
}

class _CouponTableState extends State<CouponTable> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coupons.isEmpty) {
      return _buildEmptyState();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: widget.coupons
                  .map(
                    (userCoupon) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildCouponCard(context, userCoupon),
                ),
              )
                  .toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildCouponCard(BuildContext context, UserCouponEntity userCoupon) {
    final coupon = userCoupon.coupon;

    final isExpired = DateTime.now().isAfter(coupon.expiresAt);
    final isUsed = coupon.used;

    final isPercentage = coupon.discountType == 'percentage';

    final discountValue = isPercentage
        ? '${coupon.discountValue.toStringAsFixed(0)}%'
        : '${coupon.discountValue.toStringAsFixed(0)} EGP';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.divider.withOpacity(.55)),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
            childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
            iconColor: AppColor.mainColor,
            collapsedIconColor: AppColor.textSecondary,
            title: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.local_offer_outlined,
                    color: AppColor.mainColor,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.code,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPercentage
                            ? 'نسبة مئوية • $discountValue'
                            : 'قيمة ثابتة • $discountValue',
                        style: const TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildStatus(isExpired: isExpired, isUsed: isUsed),
              ],
            ),
            children: [
              _buildExpandedContent(userCoupon, isPercentage, discountValue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent(
    UserCouponEntity userCoupon,
    bool isPercentage,
    String discountValue,
  ) {
    final coupon = userCoupon.coupon;

    final remaining = coupon.expiresAt.difference(DateTime.now());

    return Column(
      children: [
        _buildUserInfo(userCoupon),

        const SizedBox(height: 12),

        if (!coupon.used) _buildRemainingTime(remaining, coupon.expiresAt),

        if (coupon.used) _buildUsedInfo(coupon.usedAt, coupon.orderId),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColor.divider.withOpacity(.45)),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildMainValue(
                  icon: isPercentage
                      ? Icons.percent_rounded
                      : Icons.payments_outlined,
                  title: 'قيمة الخصم',
                  value: discountValue,
                ),
              ),
              Container(
                width: 1,
                height: 38,
                color: AppColor.divider.withOpacity(.5),
              ),
              Expanded(
                child: _buildMainValue(
                  icon: Icons.shopping_cart_outlined,
                  title: 'الحد الأدنى',
                  value: '${coupon.minimumOrder.toStringAsFixed(0)} EGP',
                ),
              ),
              Container(
                width: 1,
                height: 38,
                color: AppColor.divider.withOpacity(.5),
              ),
              Expanded(
                child: _buildMainValue(
                  icon: Icons.price_check_outlined,
                  title: 'أقصى خصم',
                  value: '${coupon.maxDiscount.toStringAsFixed(0)} EGP',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildDateInfo(
                icon: Icons.calendar_today_outlined,
                title: 'تاريخ الإنشاء',
                value: widget.getDateFormate(coupon.createdAt),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDateInfo(
                icon: Icons.event_available_outlined,
                title: 'تاريخ الانتهاء',
                value: widget.getDateFormate(coupon.expiresAt),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          height: 40,
          child: OutlinedButton.icon(
            onPressed: () => widget.onDelete(userCoupon),
            icon: const Icon(Icons.delete_outline_rounded, size: 18),
            label: const Text(
              'حذف الكوبون',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColor.red,
              side: BorderSide(color: AppColor.red.withOpacity(.30)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(UserCouponEntity userCoupon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColor.divider.withOpacity(.45)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColor.accentColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColor.accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الكوبون خاص بـ',
                  style: TextStyle(color: AppColor.textSecondary, fontSize: 9),
                ),
                const SizedBox(height: 3),
                Text(
                  userCoupon.user.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsedInfo(DateTime? usedAt, String? orderId) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColor.accentColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColor.accentColor.withOpacity(.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColor.accentColor.withOpacity(.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColor.accentColor,
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'تم استخدام الكوبون',
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          if (usedAt != null) ...[
            const SizedBox(height: 12),
            _buildDateInfo(
              icon: Icons.access_time_rounded,
              title: 'تاريخ الاستخدام',
              value: widget.getDateFormate(usedAt),
            ),
          ],

          if (orderId != null && orderId.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.background,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.receipt_long_outlined,
                    color: AppColor.accentColor,
                    size: 17,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'رقم الطلب',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      orderId,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.textPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRemainingTime(Duration remaining, DateTime expiresAt) {
    if (remaining.isNegative || remaining == Duration.zero) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: AppColor.red.withOpacity(.08),
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Row(
          children: [
            Icon(Icons.timer_off_outlined, color: AppColor.red, size: 20),
            SizedBox(width: 9),
            Text(
              'انتهى الكوبون',
              style: TextStyle(
                color: AppColor.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.accentColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColor.accentColor.withOpacity(.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColor.accentColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.timer_outlined,
              color: AppColor.accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'متبقي',
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          _buildTimeUnit(value: days, label: 'يوم'),
          _buildTimeSeparator(),
          _buildTimeUnit(value: hours, label: 'ساعة'),
          _buildTimeSeparator(),
          _buildTimeUnit(value: minutes, label: 'دقيقة'),
          _buildTimeSeparator(),
          _buildTimeUnit(value: seconds, label: 'ثانية'),
        ],
      ),
    );
  }

  Widget _buildTimeUnit({required int value, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: AppColor.mainColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: AppColor.textSecondary, fontSize: 8),
        ),
      ],
    );
  }

  Widget _buildTimeSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        ':',
        style: TextStyle(
          color: AppColor.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMainValue({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColor.accentColor, size: 18),
        const SizedBox(height: 5),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColor.textSecondary, fontSize: 9),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: AppColor.accentColor, size: 17),
              const SizedBox(width: 8),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(color: AppColor.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(color: AppColor.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatus({required bool isExpired, required bool isUsed}) {
    final Color color;
    final String text;
    final IconData icon;

    if (isUsed) {
      color = AppColor.textSecondary;
      text = 'مستخدم';
      icon = Icons.check_circle_outline_rounded;
    } else if (isExpired) {
      color = AppColor.red;
      text = 'منتهي';
      icon = Icons.timer_off_outlined;
    } else {
      color = Colors.green;
      text = 'نشط';
      icon = Icons.circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.divider.withOpacity(.55)),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_offer_outlined,
              color: AppColor.mainColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'لا توجد كوبونات',
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'لم يتم العثور على كوبونات مطابقة',
            style: TextStyle(color: AppColor.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
