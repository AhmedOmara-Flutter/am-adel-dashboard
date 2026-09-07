import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';import '../../../../core/utils/app_constants.dart';

import '../../../../core/utils/config_size.dart';
import 'best_seller_list_view.dart';

class BestSellerCard extends StatelessWidget {
  const BestSellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery
              .sizeOf(context)
              .width > ConfigSize.phone? 10:0,
          bottom: 10,
          left: 10,
          right:MediaQuery.sizeOf(context).width > ConfigSize.phone? 0:10
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(AppConstants.borderColor),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: AppColor.border),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 12,
              left: 15,
              right: 15,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColor.mainColor,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'أفضل المنتجات مبيعًا',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          const BestSellerListView(),
        ],
      ),
    );
  }
}
