import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';

class SkeletonizerProductItem extends StatelessWidget {
  const SkeletonizerProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFF2A2A2A),
        highlightColor: Color(0xFF3A3A3A),
        duration: Duration(milliseconds: 1200),
      ),
      child: Container(
        margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10
        ),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: AppColor.border,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              Assets.assets.images.customer.path, // غيرها باسم الميدالية عندك
              height: 30,
              width: 30,
            ),

            SizedBox(width: 12),

            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: AppColor.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColor.border,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  Assets.assets.images.customer.path, // غيرها بصورة منتج عندك
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'بيتزا سوبر سوبريم',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font15Weight700(context),
                  ),

                  SizedBox(height: 6),

                  Text(
                    '125 طلب',
                    style: StyleManager.font13Weight400(context),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColor.background.withOpacity(.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColor.border,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '125',
                        style: StyleManager.font14Weight600(context),
                      ),
                      SizedBox(width: 4),
                      Image.asset(
                        Assets.assets.images.amAdelLogo.path,
                        height: 10,
                        width: 10,
                        color: AppColor.mainColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'إجمالي الطلبات',
                    style: StyleManager.font11Weight400(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
