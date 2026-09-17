import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomShowDialog {
  static Future<void> show(BuildContext context, {
    required String title,
    required Widget content,
    VoidCallback? cancel,
    VoidCallback? accept,
    Color color = AppColor.mainColor,
    IconData flag = Icons.payment_rounded,
    String cancelText = 'إلغاء',
    String acceptText = 'تأكيد',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColor.cardLight,
          elevation: 2,
          shadowColor: AppColor.black.withOpacity(.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: AppColor.divider,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.all(22),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(.12),
                ),
                child: Icon(
                  flag,
                  size: 36,
                  color: color,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              content,

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                      cancel ?? () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.background,
                        foregroundColor: AppColor.textPrimary,
                        side: const BorderSide(
                          color: AppColor.divider,
                          width: 1.2,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        cancelText,
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: accept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: AppColor.white,
                        elevation: 2,
                        shadowColor: color.withOpacity(.30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        acceptText,
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
