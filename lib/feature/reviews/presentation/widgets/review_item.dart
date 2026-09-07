import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/route_manager.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/config_size.dart';

class ReviewItem extends StatelessWidget {
  final ProductEntity product;

  const ReviewItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.sizeOf(context).width > ConfigSize.phone?EdgeInsets.only(
        top: 2,
        bottom: 10,
        left: 10,
      ):EdgeInsets.only(
        right: 10
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColor.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${product.reviewsCount}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColor.white),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.message,
                          color: AppColor.textSecondary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {
              //       CustomShowDialog.show(
              //         context,
              //         title: "حذف جميع التعليقات",
              //         content: const Text(
              //           "هل أنت متأكد من حذف جميع التعليقات؟",
              //           textAlign: TextAlign.center,
              //         ),
              //         cancel: () => Navigator.pop(context),
              //         accept: () {
              //           context.read<GetReviewsCubit>().deleteAllReviews(product.id!);
              //           Navigator.pop(context);
              //         },
              //         color: AppColor.red,
              //         flag: Icons.warning_amber_rounded,
              //       );
              //     },
              //     icon: Icon(Icons.delete_outline,
              //       color: AppColor.red,
              //       size: 18.sp,)
              // ),
            ],
          ),
          SizedBox(height: 5),
          Column(
            children: [
              Container(
                height: 125,
                width: 125,
                child: CachedNetworkImage(
                  imageUrl: product.image ?? '',
                  fit: BoxFit.contain,
                  fadeInDuration: const Duration(milliseconds: 250),
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported_outlined,
                    size: 42,
                    color: AppColor.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColor.white
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColor.mainColor,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    product.averageRating.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManager.productReviews,
                        arguments: product,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.border,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'عرض جميع التعليقات',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}