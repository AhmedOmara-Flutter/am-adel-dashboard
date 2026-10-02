import 'package:am_adel_dashboard/core/cubit/offers_cubit/offers_cubit.dart';
import 'package:am_adel_dashboard/core/entities/offer_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferProductCard extends StatelessWidget {
  final OfferEntity offer;

  const OfferProductCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final expired = offer.isExpired;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: expired
              ? AppColor.red.withOpacity(.28)
              : AppColor.divider.withOpacity(.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (expired) const _ExpiredHeader(),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductImage(
                      imageUrl: offer.image,
                      expired: expired,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: _ProductHeader(
                        offer: offer,
                        expired: expired,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _DeleteButton(
                      onPressed: () => _deleteOffer(context),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _OfferPrice(
                  offer: offer,
                  expired: expired,
                ),
              ],
            ),
          ),

          _OfferFooter(
            offer: offer,
            expired: expired,
          ),
        ],
      ),
    );
  }

  void _deleteOffer(BuildContext context) {
    CustomShowDialog.show(
      context,
      title: 'حذف العرض',
      content: Text(
        'هل أنت متأكد أنك تريد حذف هذا العرض؟',
        style: StyleManager.font12Weight500(context).copyWith(
            height: 1.5,
            color: AppColor.textSecondary
        ),
      ),
      cancel: () => Navigator.pop(context),
      accept: () async {
        Navigator.pop(context);
        await context.read<OffersCubit>().deleteOffer(offer);
      },
      flag: Icons.local_offer_outlined,
      color: AppColor.red,
    );
  }
}

class _ExpiredHeader extends StatelessWidget {
  const _ExpiredHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColor.red.withOpacity(.075),
        border: Border(
          bottom: BorderSide(
            color: AppColor.red.withOpacity(.12),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_off_outlined,
            size: 17,
            color: AppColor.red,
          ),
          const SizedBox(width: 7),
          Text(
            'العرض منتهي',
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(
              color: AppColor.red,
            ),
          ),
          const Spacer(),
          Text(
            'غير متاح',
            style: StyleManager.font11Weight400(
              context,
            ).copyWith(
              color: AppColor.red.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool expired;

  const _ProductImage({
    required this.imageUrl,
    required this.expired,
  });

  @override
  Widget build(BuildContext context) {
    final color = expired
        ? AppColor.red
        : AppColor.mainColor;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 82,
          height: 82,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColor.backgroundDark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (_, __) {
                return Center(
                  child: SizedBox(
                    width: 17,
                    height: 17,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.7,
                      color: AppColor.mainColor,
                    ),
                  ),
                );
              },
              errorWidget: (_, __, ___) {
                return Icon(
                  Icons.image_not_supported_outlined,
                  size: 24,
                  color: AppColor.textSecondary.withOpacity(.4),
                );
              },
            ),
          ),
        ),
        Positioned(
          left: -6,
          bottom: -6,
          child: Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.cardLight,
                width: 2,
              ),
            ),
            child: Icon(
              expired
                  ? Icons.close_rounded
                  : Icons.local_offer_rounded,
              size: 13,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductHeader extends StatelessWidget {
  final OfferEntity offer;
  final bool expired;

  const _ProductHeader({
    required this.offer,
    required this.expired,
  });

  @override
  Widget build(BuildContext context) {
    final color = expired
        ? AppColor.red
        : AppColor.mainColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              expired ? 'منتهي' : 'نشط الآن',
              style: StyleManager.font11Weight400(
                context,
              ).copyWith(
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          offer.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font16Weight700(
            context,
          ).copyWith(
            color: AppColor.textPrimary,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 13,
              color: AppColor.textSecondary.withOpacity(.65),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '${_formatDate(offer.startDate)}  ←  ${_formatDate(
                    offer.endDate)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _OfferPrice extends StatelessWidget {
  final OfferEntity offer;
  final bool expired;

  const _OfferPrice({
    required this.offer,
    required this.expired,
  });

  @override
  Widget build(BuildContext context) {
    final color = expired
        ? AppColor.red
        : AppColor.mainColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 68,
          height: 58,
          decoration: BoxDecoration(
            color: color.withOpacity(.09),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: color.withOpacity(.14),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${offer.discountPercentage.toStringAsFixed(0)}%',
                style: StyleManager.font18Weight700(
                  context,
                ).copyWith(
                  color: color,
                ),
              ),
              Text(
                'خصم',
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'السعر بعد الخصم',
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      offer.priceAfterDiscount
                          .toStringAsFixed(2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font23Weight700(
                        context,
                      ).copyWith(
                        color: expired
                            ? AppColor.textSecondary
                            : AppColor.mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      'جنيه',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Container(
          width: 1,
          height: 43,
          color: AppColor.divider.withOpacity(.45),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'قبل الخصم',
              style: StyleManager.font11Weight400(
                context,
              ).copyWith(
                color: AppColor.textSecondary,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${offer.priceBeforeDiscount.toStringAsFixed(2)} جنيه',
              style: StyleManager.font12Weight500(
                context,
              ).copyWith(
                color: AppColor.textSecondary,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColor.red.withOpacity(.65),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OfferFooter extends StatelessWidget {
  final OfferEntity offer;
  final bool expired;

  const _OfferFooter({
    required this.offer,
    required this.expired,
  });

  @override
  Widget build(BuildContext context) {
    final color = expired
        ? AppColor.red
        : AppColor.mainColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: expired
            ? AppColor.red.withOpacity(.025)
            : AppColor.background.withOpacity(.4),
        border: Border(
          top: BorderSide(
            color: expired
                ? AppColor.red.withOpacity(.1)
                : AppColor.divider.withOpacity(.35),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_outlined,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 7),
          Text(
            expired ? 'انتهى العرض في' : 'العرض متاح حتى',
            style: StyleManager.font11Weight400(
              context,
            ).copyWith(
              color: AppColor.textSecondary,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            _formatDate(offer.endDate),
            style: StyleManager.font12Weight500(
              context,
            ).copyWith(
              color: color,
            ),
          ),
          const Spacer(),
          if (!expired)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'ساري',
                  style: StyleManager.font11Weight400(
                    context,
                  ).copyWith(
                    color: AppColor.mainColor,
                  ),
                ),
              ],
            )
          else
            Text(
              'منتهي',
              style: StyleManager.font11Weight400(
                context,
              ).copyWith(
                color: AppColor.red,
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColor.red.withOpacity(.07),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 18,
            color: AppColor.red.withOpacity(.75),
          ),
        ),
      ),
    );
  }
}
