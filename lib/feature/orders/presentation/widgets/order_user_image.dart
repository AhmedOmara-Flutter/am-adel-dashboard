import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';

import '../../../../core/helper_function/make_call_function.dart';
import '../../../../generated/assets.dart';

class OrderUserImage extends StatelessWidget {
  const OrderUserImage({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => makePhoneCall(order.userEntity!.phone),
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.divider,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            Assets.assets.images.customer.path,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}