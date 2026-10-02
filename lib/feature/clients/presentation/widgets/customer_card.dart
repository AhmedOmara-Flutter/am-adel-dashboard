import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import '../../../../core/helper_function/make_call_function.dart';
import 'customer_stat.dart';

class CustomerCard extends StatelessWidget {
  final UserEntity user;
  final List<OrderEntity> orders;

  const CustomerCard({
    super.key,
    required this.user,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    final totalAmount =
        orders.fold(
          0.0,
              (sum, order) =>
          sum + order.cartEntity.getTotalPrice(),
        ) +
            orders.fold(
              0.0,
                  (sum, order) =>
              sum + (order.selectedLocationEntity?.cost ?? 0),
            );

    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.mainColor.withOpacity(.25),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: AppColor.backgroundDark,
                  backgroundImage: AssetImage(
                    Assets.assets.images.customer.path,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makeFullName(user.userName),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font13Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        makePhoneCall(user.phone);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: AppColor.mainColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            user.phone,
                            style: StyleManager.font12Weight500(
                              context,
                            ).copyWith(

                              color: AppColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (orders.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManager.displayOrders,
                      arguments: orders,
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.06),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                            AppColor.mainColor.withOpacity(.12),
                          ),
                        ),
                        child: Icon(
                          Icons.receipt_long_rounded,
                          size: 20,
                          color: AppColor.mainColor,
                        ),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.cardLight,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${orders.length}',
                              style: StyleManager.font13Weight600(
                                context,
                              ).copyWith(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            color: AppColor.divider.withOpacity(.35),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CustomerStat(
                  icon: Icons.shopping_bag_outlined,
                  value: '${orders.length}',
                  label: 'الطلبات',
                ),
              ),
              Container(
                height: 32,
                width: 1,
                color: AppColor.divider.withOpacity(.4),
              ),
              Expanded(
                child: CustomerStat(
                  icon: Icons.payments_outlined,
                  value: '${totalAmount.toStringAsFixed(0)} ج.م',
                  label: 'إجمالي الشراء',
                ),
              ),
              Container(
                height: 32,
                width: 1,
                color: AppColor.divider.withOpacity(.4),
              ),
              Expanded(
                child: CustomerStat(
                  icon: Icons.calendar_today_outlined,
                  value: getDateFormate(
                    user.createdAt.toString(),
                  ),
                  label: 'تاريخ التسجيل',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

