import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/enums/order_enum.dart';
import 'display_product_item.dart';
import 'order_total_section.dart';

class DisplayOrderCard extends StatelessWidget {
  final OrderEntity order;
  final int orderNumber;

  const DisplayOrderCard({
    super.key,
    required this.order,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    final location = order.selectedLocationEntity;
    final isCash = order.isCashOnDelivery ?? false;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.divider.withOpacity(.55)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
          childrenPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          iconColor: AppColor.mainColor,
          collapsedIconColor: AppColor.textSecondary,
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          leading: _OrderIcon(color: order.status.color),
          title: _OrderTitle(
            orderNumber: orderNumber,
            date: getDateFormate(order.createdAt.toString()),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Row(
              children: [
                _StatusBadge(color: order.status.color, title: order.status.ar),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    location?.title ?? 'العنوان غير محدد',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(color: AppColor.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              padding: const EdgeInsets.only(top: 14),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.divider.withOpacity(.4)),
                ),
              ),
              child: Column(
                children: [
                  _OrderInfo(
                    location: location?.title ?? 'غير محدد',
                    payment: isCash ? 'الدفع كاش' : 'دفع أونلاين',
                    paymentIcon: isCash
                        ? Icons.payments_outlined
                        : Icons.credit_card_outlined,
                  ),
                  const SizedBox(height: 18),
                  _SectionTitle(count: order.cartEntity.cartItems.length),
                  const SizedBox(height: 7),
                  Column(
                    children: [
                      for (
                        int i = 0;
                        i < order.cartEntity.cartItems.length;
                        i++
                      )
                        DisplayProductItem(item: order.cartEntity.cartItems[i]),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(height: 1, color: AppColor.divider.withOpacity(.4)),
                  const SizedBox(height: 14),
                  OrderTotalSection(
                    total: order.cartEntity.getTotalPrice(),
                    delivery: location?.cost ?? 0,
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

class _OrderIcon extends StatelessWidget {
  final Color color;

  const _OrderIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withOpacity(.09),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.receipt_long_outlined, size: 20, color: color),
    );
  }
}

class _OrderTitle extends StatelessWidget {
  final int orderNumber;
  final String date;

  const _OrderTitle({required this.orderNumber, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'طلب',
          style: StyleManager.font12Weight500(
            context,
          ).copyWith(color: AppColor.textSecondary),
        ),
        const SizedBox(width: 5),
        Text(
          '#${orderNumber.toString().padLeft(2, '0')}',
          style: StyleManager.font13Weight600(
            context,
          ).copyWith(color: AppColor.textPrimary, fontSize: 16),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final Color color;
  final String title;

  const _StatusBadge({required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: StyleManager.font13Weight600(
              context,
            ).copyWith(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _OrderInfo extends StatelessWidget {
  final String location;
  final String payment;
  final IconData paymentIcon;

  const _OrderInfo({
    required this.location,
    required this.payment,
    required this.paymentIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoItem(
            icon: Icons.location_on_outlined,
            title: 'التوصيل',
            value: location,
            color: AppColor.mainColor,
          ),
        ),
        Container(
          width: 1,
          height: 34,
          color: AppColor.divider.withOpacity(.45),
        ),
        Expanded(
          child: _InfoItem(
            icon: paymentIcon,
            title: 'الدفع',
            value: payment,
            color: AppColor.accentColor,
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: StyleManager.font11Weight400(
                    context,
                  ).copyWith(color: AppColor.textSecondary, fontSize: 10),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font13Weight600(
                    context,
                  ).copyWith(color: AppColor.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final int count;

  const _SectionTitle({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 17,
          decoration: BoxDecoration(
            color: AppColor.mainColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'المنتجات',
          style: StyleManager.font13Weight600(
            context,
          ).copyWith(color: AppColor.textPrimary),
        ),
        const Spacer(),
        Text(
          '$count منتجات',
          style: StyleManager.font11Weight400(
            context,
          ).copyWith(color: AppColor.textSecondary),
        ),
      ],
    );
  }
}
