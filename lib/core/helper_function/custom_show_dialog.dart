import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';

  class CustomShowDialog {
    static Future<void> show(
        BuildContext context, {
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
            backgroundColor: AppColor.card,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            contentPadding: EdgeInsets.all(22),
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

                SizedBox(height: 18),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                content,

                SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: cancel ?? () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColor.card,
                          foregroundColor: AppColor.textPrimary,
                          side: BorderSide(
                            color: AppColor.border,
                            width: 1.2,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          cancelText,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: accept,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: color.withOpacity(.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          acceptText,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )            ],
            ),
          );
        },
      );
    }
  }