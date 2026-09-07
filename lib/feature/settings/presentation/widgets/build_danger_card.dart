import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

class DangerCard extends StatelessWidget {
  const DangerCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.dialogTitle,
    this.dialogContent,
    this.dialogIcon,
  });

  final String title;
  final String description;
  final String buttonText;

  final IconData icon;
  final IconData? dialogIcon;

  final Color color;

  final VoidCallback onPressed;

  final String? dialogTitle;
  final String? dialogContent;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(.16),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              15,
            ),
            child: Column(
              children: [
                // ===============================
                // HEADER
                // ===============================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Container
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: color.withOpacity(.10),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: color.withOpacity(.18),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: color.withOpacity(.07),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(
                            icon,
                            color: color,
                            size: 24,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 13),

                    // ===============================
                    // TITLE + DESCRIPTION
                    // ===============================

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                    color: AppColor.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 7),

                              // DANGER BADGE
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(.10),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'خطر',
                                  style: StyleManager
                                      .font11Weight400(context)
                                      .copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager
                                .font12Weight500(context)
                                .copyWith(
                              color: AppColor.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Container(
                  height: 1,
                  color: AppColor.border.withOpacity(.55),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    // Warning
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColor.textSecondary.withOpacity(.7),
                            size: 16,
                          ),

                          const SizedBox(width: 6),

                          Flexible(
                            child: Text(
                              'هذا الإجراء لا يمكن التراجع عنه',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager
                                  .font11Weight400(context)
                                  .copyWith(
                                color: AppColor.textSecondary
                                    .withOpacity(.75),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // ===============================
                    // DELETE BUTTON
                    // ===============================

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          CustomShowDialog.show(
                            context,
                            title: dialogTitle ?? title,
                            content: Text(
                              dialogContent ?? description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                            cancel: () {
                              Navigator.pop(context);
                            },
                            accept: () {
                              onPressed();
                              Navigator.pop(context);
                            },
                            color: color,
                            flag: dialogIcon ?? icon,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(.10),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: color.withOpacity(.20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: color,
                                size: 17,
                              ),

                              const SizedBox(width: 6),

                              Text(
                                buttonText,
                                style: StyleManager
                                    .font11Weight400(context)
                                    .copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}