
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PaymentCardSection extends StatelessWidget {
  const PaymentCardSection({
    super.key,
    required this.paymentMethod,
    this.paymentImage,
  });

  final String paymentMethod;
  final String? paymentImage;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        paymentImage != null && paymentImage!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider.withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 20,
                color: AppColor.mainColor,
              ),
              const SizedBox(width: 9),
              Text(
                'طريقة الدفع',
                style: StyleManager.font14Weight600(
                  context,
                ).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColor.green.withOpacity(.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.payments_outlined,
                  color: AppColor.green,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  paymentMethod,
                  style: StyleManager.font13Weight600(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.check_circle_outline_rounded,
                size: 19,
                color: AppColor.green,
              ),
            ],
          ),

          if (hasImage) ...[
            const SizedBox(height: 15),

            Container(
              height: 1,
              color: AppColor.divider.withOpacity(.4),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Text(
                  'إثبات الدفع',
                  style: StyleManager.font13Weight600(
                    context,
                  ).copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  'اضغط للتكبير',
                  style: StyleManager.font11Weight400(
                    context,
                  ).copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.zoom_in_rounded,
                  size: 15,
                  color: AppColor.textSecondary,
                ),
              ],
            ),

            const SizedBox(height: 9),

            GestureDetector(
              onTap: () =>
                  _showPaymentImage(
                    context,
                    paymentImage!,
                  ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: paymentImage!,
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          Container(
                            height: 190,
                            color: AppColor.background,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                      errorWidget: (_, __, ___) =>
                          Container(
                            height: 190,
                            color: AppColor.background,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColor.textSecondary,
                              size: 27,
                            ),
                          ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.55),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.zoom_in_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showPaymentImage(BuildContext context,
      String imageUrl,) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
}
}
