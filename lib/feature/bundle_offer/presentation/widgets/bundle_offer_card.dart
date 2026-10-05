import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_offer_entity.dart';
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.32)),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageSection(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 12),
                    _buildDate(context),
                    const SizedBox(height: 12),
                    _buildDescription(context),
                    const SizedBox(height: 14),
                    _buildBottom(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColor.backgroundDark.withOpacity(0.70),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppConstants.borderRadius),
                bottomRight: Radius.circular(AppConstants.borderRadius),
              ),
            ),
            child: _buildImage(context),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.cardLight.withOpacity(.94),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.divider),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_offer_rounded,
                    size: 13,
                    color: AppColor.mainColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'عرض',
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(color: AppColor.mainColor),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.secondaryColor.withOpacity(.90),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bundleOffer.price.toStringAsFixed(0),
                    style: StyleManager.font15Weight800(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'ج.م',
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(color: Colors.white.withOpacity(.8)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            bundleOffer.title,
            softWrap: true,
            style: StyleManager.font15Weight800(
              context,
            ).copyWith(color: AppColor.textPrimary, height: 1.3),
          ),
        ),
        if (onDelete != null) ...[
          const SizedBox(width: 12),
          _buildDeleteButton(),
        ],
      ],
    );
  }

  Widget _buildDeleteButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onDelete,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColor.red.withOpacity(.07),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColor.red.withOpacity(.14)),
          ),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 19,
            color: AppColor.red,
          ),
        ),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColor.backgroundDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.calendar_month_rounded,
            size: 14,
            color: AppColor.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          getDateFormate(bundleOffer.createdAt.toString()),
          style: StyleManager.font11Weight400(
            context,
          ).copyWith(color: AppColor.textSecondary),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColor.backgroundDark.withOpacity(.55),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        bundleOffer.description,
        softWrap: true,
        overflow: TextOverflow.visible,
        style: StyleManager.font12Weight500(
          context,
        ).copyWith(color: AppColor.textSecondary, height: 1.65),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.08),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.restaurant_menu_rounded,
                size: 14,
                color: AppColor.mainColor,
              ),
              const SizedBox(width: 6),
              Text(
                'باقة مميزة',
                style: StyleManager.font12Weight500(
                  context,
                ).copyWith(color: AppColor.mainColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        if (onDelete != null)
          Text(
            'إدارة العرض',
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(color: AppColor.textSecondary),
          ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final image = bundleOffer.image;

    if (image != null && image.trim().isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
        placeholder: (context, url) {
          return _imagePlaceholder(context, loading: true);
        },
        errorWidget: (context, url, error) {
          return _imagePlaceholder(context);
        },
      );
    }

    return _imagePlaceholder(context);
  }

  Widget _imagePlaceholder(BuildContext context, {bool loading = false}) {
    return Container(
      color: AppColor.backgroundDark,
      alignment: Alignment.center,
      child: loading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
                strokeWidth: 2,
              ),
            )
          : Icon(
              Icons.fastfood_rounded,
              size: 42,
              color: AppColor.mainColor.withOpacity(.7),
            ),
    );
  }
}
