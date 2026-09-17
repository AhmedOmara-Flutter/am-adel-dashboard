import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/entities/bundle_offer_entity.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class BundleOfferCard extends StatelessWidget {
  const BundleOfferCard({
    super.key,
    required this.bundleOffer,
    this.onDelete,
  });

  final BundleOfferEntity bundleOffer;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondaryColor.withOpacity(.10),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: double.infinity,
            child: _buildImage(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          bundleOffer.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font16Weight700(
                            context,
                          ).copyWith(
                            color: AppColor.textPrimary,
                            height: 1.25,
                          ),
                        ),
                      ),
                      if (onDelete != null) ...[
                        const SizedBox(width: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onDelete,
                            borderRadius: BorderRadius.circular(9),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColor.red.withOpacity(.07),
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: AppColor.red.withOpacity(.15),
                                ),
                              ),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                size: 18,
                                color: AppColor.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 13,
                        color: AppColor.textSecondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        getDateFormate(
                          bundleOffer.createdAt.toString(),
                        ),
                        style: StyleManager.font12Weight500(
                          context,
                        ).copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color: AppColor.divider.withOpacity(.7),
                        ),
                      ),
                      child: Text(
                        bundleOffer.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font13Weight600(
                          context,
                        ).copyWith(
                          color: AppColor.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.backgroundDark,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.divider,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              bundleOffer.price.toStringAsFixed(0),
                              style: StyleManager.font19Weight700(
                                context,
                              ).copyWith(
                                color: AppColor.mainColor,
                                height: 1,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'ج.م',
                              style: StyleManager.font11Weight400(
                                context,
                              ).copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (onDelete != null)
                        const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (bundleOffer.image != null &&
        bundleOffer.image!.trim().isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: bundleOffer.image!,
        fit: BoxFit.contain,
        placeholder: (context, url) {
          return Container(
            color: AppColor.backgroundDark,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return _imagePlaceholder();
        },
      );
    }

    return _imagePlaceholder();
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColor.backgroundDark,
      child: Center(
        child: Icon(
          Icons.fastfood_outlined,
          size: 42,
          color: AppColor.mainColor,
        ),
      ),
    );
  }
}