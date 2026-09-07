import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../core/widgets/custom_back_button.dart';
import 'display_order_card.dart';


class DisplayOrdersViewBody extends StatelessWidget {
  final List<OrderEntity> orders;
  const DisplayOrdersViewBody({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomBackButton(),
              Row(
                children: [
                  Icon(Icons.display_settings, color: AppColor.mainColor),
                  const SizedBox(width: 8),
                  Text(
                    "عرض الطلبات",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 40),
            ],
          ),
        ),
        MediaQuery.sizeOf(context).width > ConfigSize.phone
            ? Expanded(
                child: GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: orders.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (context, index) {
              return DisplayOrderCard(
                order: orders[index],
                orderNumber: orders.length - index,
              );
            },
          ),
              )
            : Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    return DisplayOrderCard(
                      order: orders[index],
                      orderNumber: orders.length - index,
                    );
                  },
                ),
            ),
      ],
    );
  }
}
