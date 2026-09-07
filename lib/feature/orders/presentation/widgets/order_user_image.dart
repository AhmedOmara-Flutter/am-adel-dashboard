
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';

import '../../../../core/helper_function/make_call_function.dart';
import '../../../../generated/assets.dart';

class OrderUserImage extends StatelessWidget {
  const OrderUserImage({
    super.key, required this.order,


  });

  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => makePhoneCall(order.userEntity!.phone),
      child: ClipOval(
        child: Image.asset(
          Assets.assets.images.customer.path,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}