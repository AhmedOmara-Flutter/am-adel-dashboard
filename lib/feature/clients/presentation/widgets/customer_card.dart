import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/helper_function/make_full_name.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/generated/assets.dart';
import '../../../../core/helper_function/make_call_function.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../core/utils/route_manager.dart';
import 'customer_info_item.dart';

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
              (sum, order) => sum + order.cartEntity.getTotalPrice(),
        ) +
            orders.fold(
              0.0,
                  (sum, order) => sum + order.selectedLocationEntity!.cost,
            );

    return Container(
      padding: EdgeInsets.all(14),
      margin: MediaQuery.sizeOf(context).width > ConfigSize.phone
          ? EdgeInsets.all(10)
          : EdgeInsets.only(
        top: 5,
        left: 10,
        right: 10,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondaryColor.withOpacity(.12),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColor.divider,
          ),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColor.backgroundDark,
                backgroundImage: AssetImage(
                  Assets.assets.images.customer.path,
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makeFullName(user.userName),
                      style: StyleManager.font13Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      user.email,
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),

                    SizedBox(height: 2),

                    GestureDetector(
                      onTap: () {
                        makePhoneCall(user.phone);
                      },
                      child: Text(
                        user.phone,
                        style: StyleManager.font12Weight500(
                          context,
                        ).copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      getDateFormate(
                        user.createdAt.toString(),
                      ),
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 10),

              if (orders.isNotEmpty) ...[
                MaterialButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  color: AppColor.mainColor,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteManager.displayOrders,
                      arguments: orders,
                    );
                  },
                  child: Text(
                    'عرض الطلبات',
                    style: StyleManager.font12Weight500(
                      context,
                    ).copyWith(
                      color: AppColor.textOnDark,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: CustomerInfoItem(
                  icon: Icons.shopping_bag_outlined,
                  title: '${orders.length}',
                  subtitle: 'طلبات',
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: CustomerInfoItem(
                  icon: Icons.payments_outlined,
                  title: '${totalAmount.toStringAsFixed(0)} ج.م',
                  subtitle: 'إجمالي الشراء',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}