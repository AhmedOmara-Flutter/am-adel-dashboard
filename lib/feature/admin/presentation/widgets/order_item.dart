import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/assets.dart';
import '../../../main/presentation/view_model/main_cubit.dart';
import '../../../orders/presentation/widgets/order_status_badge.dart';

class OrderItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColor.mainColor.withOpacity(.04),
        highlightColor: AppColor.mainColor.withOpacity(.02),
        onTap: () {
          context.read<MainCubit>().changeIndex(5);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.divider.withOpacity(.38)),
          ),
          child: Row(
            children: [
              _Avatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            customerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font15Weight700(
                              context,
                            ).copyWith(color: AppColor.textPrimary),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: AppColor.accentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      products,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(color: AppColor.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _Meta(icon: Icons.schedule_outlined, text: time),
                        const SizedBox(width: 12),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppColor.divider,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _Meta(
                          icon: Icons.local_shipping_outlined,
                          text: '${deliveryCost.toStringAsFixed(0)} ج.م',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderStatusBadge(color: statusColor, title: status),
                  const SizedBox(height: 8),
                  Text(
                    '${amount.toStringAsFixed(2)} ج.م',
                    maxLines: 1,
                    style: StyleManager.font16Weight700(
                      context,
                    ).copyWith(color: AppColor.mainColor),
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

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.backgroundDark.withOpacity(.35),
        border: Border.all(color: AppColor.divider.withOpacity(.65)),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: Image.asset(
          Assets.assets.images.customer.path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColor.textSecondary.withOpacity(.65)),
        const SizedBox(width: 4),
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font11Weight400(
            context,
          ).copyWith(color: AppColor.textSecondary),
        ),
      ],
    );
  }
}
