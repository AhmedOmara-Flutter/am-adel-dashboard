import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';

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
      barrierColor: AppColor.black.withOpacity(.72),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 24,
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 470,
            ),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.divider.withOpacity(.65),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withOpacity(.40),
                  blurRadius: 45,
                  spreadRadius: 3,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // =========================================================
                  // TOP
                  // =========================================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      20,
                      22,
                      18,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          color.withOpacity(.16),
                          color.withOpacity(.06),
                          AppColor.cardLight,
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon container
                        Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            color: color.withOpacity(.10),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: color.withOpacity(.20),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(.10),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Icon(
                                flag,
                                color: color,
                                size: 27,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 15),

                        // Title
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(.10),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  'تأكيد الإجراء',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  color: AppColor.textPrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Accent line
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 65,
                      height: 3,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(.30),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =========================================================
                  // CONTENT
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      20,
                      22,
                      20,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.background.withOpacity(.45),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColor.divider.withOpacity(.50),
                        ),
                      ),
                      child: content,
                    ),
                  ),

                  // =========================================================
                  // ACTIONS
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      0,
                      22,
                      22,
                    ),
                    child: Row(
                      children: [
                        // Cancel
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: cancel ??
                                      () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                AppColor.background.withOpacity(.45),
                                foregroundColor: AppColor.textPrimary,
                                side: BorderSide(
                                  color:
                                  AppColor.divider.withOpacity(.75),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(13),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                cancelText,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                  color: AppColor.textPrimary,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 11),

                        // Accept
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: accept,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: color,
                                foregroundColor: AppColor.white,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(13),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 18,
                                    color: AppColor.white,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    acceptText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                      color: AppColor.white,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}