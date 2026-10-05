import 'package:am_adel_dashboard/core/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/flash_offer_entity.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class FlashOfferCard extends StatelessWidget {
  const FlashOfferCard({
    super.key,
    required this.flashOffer,
    this.onDelete,
  });

  final FlashOfferEntity flashOffer;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 155,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.border.withOpacity(.32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.045),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildImage(context),

          /// Dark overlay
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.18),
                  Colors.black.withOpacity(.08),
                  Colors.black.withOpacity(.68),
                ],
              ),
            ),
          ),

          /// Flash badge
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainColor.withOpacity(.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.flash_on_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'FLASH OFFER',
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color: Colors.white,
                      letterSpacing: .3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Delete
          if (onDelete != null)
            Positioned(
              top: 12,
              right: 12,
              child: _buildDeleteButton(),
            ),

          /// Bottom information
          Positioned(
            left: 14,
            right: 14,
            bottom: 12,
            child: Row(
              children: [
                _buildDate(context),
                const Spacer(),
                _buildStatus(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final image = flashOffer.image;

    if (image != null && image.trim().isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
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

  Widget _buildDeleteButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onDelete,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.45),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: Colors.white.withOpacity(.16),
            ),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            size: 19,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.46),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(.10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.calendar_month_rounded,
            size: 13,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            getDateFormate(
              flashOffer.createdAt.toString(),
            ),
            style: StyleManager.font11Weight400(
              context,
            ).copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColor.green.withOpacity(.90),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 13,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          Text(
            'نشط',
            style: StyleManager.font11Weight400(
              context,
            ).copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder(
      BuildContext context, {
        bool loading = false,
      }) {
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
        Icons.image_rounded,
        size: 42,
        color: AppColor.mainColor.withOpacity(.7),
      ),
    );
  }
}