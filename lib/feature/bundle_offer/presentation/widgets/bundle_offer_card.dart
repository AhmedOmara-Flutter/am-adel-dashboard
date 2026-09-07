import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/entities/bundle_offer_entity.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class BundleOfferCard extends StatelessWidget {
  const BundleOfferCard({super.key, required this.bundleOffer, this.onDelete});

  final BundleOfferEntity bundleOffer;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.border.withOpacity(.6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(width: 150, height: double.infinity, child: _buildImage()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bundleOffer.title,
                    style: StyleManager.font16Weight700(
                      context,
                    ).copyWith(color: Colors.white, height: 1.25),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 12,
                        color: Colors.white.withOpacity(.25),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        getDateFormate(bundleOffer.createdAt.toString()),
                        style: StyleManager.font12Weight500(
                          context,
                        ).copyWith(color: Colors.white.withOpacity(.4)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        bundleOffer.description,
                        style: StyleManager.font13Weight600(
                          context,
                        ).copyWith(color: AppColor.white.withOpacity(.42)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.mainColor.withOpacity(.18),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              bundleOffer.price.toStringAsFixed(0),
                              style: StyleManager.font19Weight700(
                                context,
                              ).copyWith(color: AppColor.mainColor, height: 1),
                            ),

                            const SizedBox(width: 5),

                            Text(
                              'ج.م',
                              style: StyleManager.font11Weight400(context)
                                  .copyWith(
                                    color: AppColor.mainColor.withOpacity(.55),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (onDelete != null)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: onDelete,
                                borderRadius: BorderRadius.circular(9),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColor.red.withOpacity(.06),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 18,
                                    color: AppColor.red.withOpacity(.7),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
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
    if (bundleOffer.image != null && bundleOffer.image!.trim().isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: bundleOffer.image!,
        fit: BoxFit.fill,
        placeholder: (context, url) {
          return const Center(
            child: SizedBox(
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
      color: AppColor.background,
      child: const Center(
        child: Icon(
          Icons.fastfood_outlined,
          size: 42,
          color: AppColor.mainColor,
        ),
      ),
    );
  }
}
