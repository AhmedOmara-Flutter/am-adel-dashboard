import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

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
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'طريقة الدفع',
            style: StyleManager.font13Weight600(context).copyWith(
              color: AppColor.white,
            ),
          ),

          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.border,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.payments_outlined,
                    color: Colors.green,
                    size: 16,
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Text(
                    paymentMethod,
                    style: StyleManager.font12Weight500(context).copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (paymentImage != null) ...[
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black87,
                  builder: (_) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(16),
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: paymentImage!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: paymentImage!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 180,
                    color: AppColor.background,
                  ),
                  errorWidget: (_, __, ___) => Container(
                    height: 180,
                    color: AppColor.background,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColor.textSecondary,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}