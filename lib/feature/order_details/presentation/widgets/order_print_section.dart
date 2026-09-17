import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class OrderPrintSection extends StatelessWidget {
  final VoidCallback? onPressed;

  const OrderPrintSection({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColor.backgroundDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.print_rounded,
                  color: AppColor.mainColor,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طباعة الطلب',
                      style: StyleManager.font14Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      'طباعة تفاصيل الطلب والفاتورة على الطابعة',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 44,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.print_rounded,
                size: 19,
              ),
              label: Text(
                'طباعة الطلب',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.textOnDark,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainColor,
                foregroundColor: AppColor.textOnDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}