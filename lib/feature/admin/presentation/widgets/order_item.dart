import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/config_size.dart';
import '../../../../generated/assets.dart';
import '../../../orders/presentation/widgets/order_status_badge.dart';

class OrderItem extends StatefulWidget {
  final double amount;
  final String status;
  final Color statusColor;
  final String customerName;
  final String time;
  final String products;
  final double deliveryCost;

  const OrderItem({
    super.key,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.customerName,
    required this.time,
    required this.products,
    required this.deliveryCost,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop =
        MediaQuery
            .sizeOf(context)
            .width > ConfigSize.phone;

    return MouseRegion(
      onEnter: (_) {
        if (isDesktop) {
          setState(() => isHovering = true);
        }
      },
      onExit: (_) {
        if (isDesktop) {
          setState(() => isHovering = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: isDesktop ? 5 : 2,
        ),
        decoration: BoxDecoration(
          color: isHovering
              ? AppColor.backgroundDark.withOpacity(.45)
              : AppColor.cardLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isHovering
                ? widget.statusColor.withOpacity(.22)
                : AppColor.divider.withOpacity(.40),
          ),
          boxShadow: [
            BoxShadow(
              color: widget.statusColor.withOpacity(
                isHovering ? .10 : .035,
              ),
              blurRadius: isHovering ? 18 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
// =================================================
// CUSTOMER IMAGE
// =================================================

              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.statusColor.withOpacity(.10),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        Assets.assets.images.customer.path,
                        width: isDesktop ? 55 : 58,
                        height: isDesktop ? 55 : 58,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

// Online / order indicator
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: widget.statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.cardLight,
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 13),

// =================================================
// CUSTOMER + PRODUCTS
// =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.customerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager
                                .font13Weight600(context)
                                .copyWith(
                              color: AppColor.textPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      widget.products,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager
                          .font12Weight500(context)
                          .copyWith(
                        color: AppColor.textSecondary,
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 13,
                          color: AppColor.textSecondary.withOpacity(.70),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.time,
                          style: StyleManager
                              .font12Weight500(context)
                              .copyWith(
                            color: AppColor.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

// =================================================
// RIGHT SIDE
// =================================================

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OrderStatusBadge(
                    color: widget.statusColor,
                    title: widget.status,
                  ),

                  const SizedBox(height: 9),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.amount.toStringAsFixed(2),
                        style: StyleManager
                            .font13Weight600(context)
                            .copyWith(
                          color: AppColor.mainColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'ج.م',
                        style: StyleManager
                            .font12Weight500(context)
                            .copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
