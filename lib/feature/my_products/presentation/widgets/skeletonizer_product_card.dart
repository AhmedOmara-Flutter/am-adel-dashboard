import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../generated/assets.dart';

class SkeletonizerProductCard extends StatelessWidget {
  final ProductEntity product;


  const SkeletonizerProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {

    return Skeletonizer(
        effect: const ShimmerEffect(
          baseColor: Color(0xFF2A2A2A),
          highlightColor: Color(0xFF3A3A3A),
          duration: Duration(milliseconds: 1200),
        ),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border(bottom: BorderSide(color: AppColor.border)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 95,
                      height: 95,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColor.border),
                      ),
                      child: Image.asset(
                        Assets.assets.images.customer.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'product.name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        'hhgbvfcrdertfvgbhjbgvfcydxtes frderfvgbhnhbgvufycdtrbhgfcdvghbiuuu',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        '{product.price} ج',
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColor.mainColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 60),
                Expanded(
            child: Container(
            margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.card.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.border,
          ),
        ),
        child: Text(
          'تعديل',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColor.white,
          ),
        ),
      ),
    ),
            SizedBox(width: 10),
            Expanded(
            child: Container(
            margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.card.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.border,
          ),
        ),
        child: Text(
          'تعديل',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColor.white,
          ),
        ),
      ),
    ),
            SizedBox(width: 10),
            Expanded(
            child: Container(
            margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.card.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.border,
          ),
        ),
        child: Text(
          'تعديل',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColor.white,
          ),
        ),
      ),
    ),
                SizedBox(width: 60),

              ],
            )
          ],
        ),
      )
    );
  }
}
