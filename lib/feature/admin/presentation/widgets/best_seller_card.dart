import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';

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
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppColor.border.withOpacity(.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.07),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 16,
              left: 15,
              right: 15,
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColor.accentColor.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: AppColor.accentColor,
                    size: 22,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'أفضل المنتجات مبيعًا',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
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
