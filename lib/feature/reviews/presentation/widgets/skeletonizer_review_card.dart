import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../generated/assets.dart';

class SkeletonizerReviewCard extends StatelessWidget {
  const SkeletonizerReviewCard({
    super.key,
  });

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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.border,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                Assets.assets.images.customer.path,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'احمد عماره',
                          style: StyleManager.font15Weight700(context),
                        ),
                      ),

                      Row(
                        children: List.generate(
                          5,
                              (index) =>
                              Container(
                                margin: EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4),

                  Text(
                    'منذ يومين',
                    style: StyleManager.font11Weight400(context),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'حتى يظههذا نص تجريبي لمراجعة',
                    style: StyleManager.font13Weight400(context).copyWith(
                      height: 1.5,
                    ),
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