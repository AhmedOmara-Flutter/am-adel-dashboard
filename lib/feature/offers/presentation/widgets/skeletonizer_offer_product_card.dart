import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';

class SkeletonizerOfferProductCard extends StatelessWidget {

  const SkeletonizerOfferProductCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Assets.assets.images.img.path,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // Middle content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'offer.name',
                    style:Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "555 جنيه",
                    style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[700]),
                  ),

                ],
              ),
            ),

            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "20 % خصم",
                    style:Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColor.mainColor),
                  ),
                ),
                Text(
                  'السعر بعد الخصم',
                  style:Theme.of(context).textTheme.titleSmall,
                ),

                Text(
                  "222 جنيه",
                  style:Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.mainColor),

                ),
                SizedBox(height: 7,),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Icon(Icons.edit,color: Colors.green,)

                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Icon(Icons.delete_outline,color: Colors.red,)

                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}