import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/assets.dart';

class OrderItemDesktop extends StatelessWidget {
  final double amount;
  final String status;
  final Color statusColor;
  final String customerName;
  final String time;
  final String products;
  final double deliveryCost;

  const OrderItemDesktop({
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
        onTap: () {
          context.read<MainCubit>().changeIndex(5);
        },
        hoverColor: AppColor.mainColor.withOpacity(.025),
        splashColor: AppColor.mainColor.withOpacity(.035),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.border.withOpacity(.15),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.mainColor.withOpacity(.06),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          Assets.assets.images.customer.path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font13Weight700(
                              context,
                            ).copyWith(
                              color: AppColor.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            products.replaceAll('\n', ' • '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font11Weight400(
                              context,
                            ).copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ================= TIME =================
              Expanded(
                flex: 2,
                child: Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ),

              // ================= DELIVERY =================
              Expanded(
                flex: 2,
                child: Text(
                  deliveryCost == 0
                      ? 'مجاني'
                      : '${deliveryCost.toStringAsFixed(0)} ج.م',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font11Weight400(
                    context,
                  ).copyWith(
                    color: deliveryCost == 0
                        ? AppColor.green
                        : AppColor.textSecondary,
                  ),
                ),
              ),

              // ================= STATUS =================
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                        color: statusColor,
                      ),
                    ),
                  ),
                ),
              ),

              // ================= TOTAL =================
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '${amount.toStringAsFixed(2)} ج.م',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font13Weight700(
                      context,
                    ).copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}