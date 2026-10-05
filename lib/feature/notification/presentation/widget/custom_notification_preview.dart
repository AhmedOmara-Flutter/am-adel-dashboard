import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class CustomNotificationPreview extends StatelessWidget {
  const CustomNotificationPreview({
    super.key,
    required this.titleController,
    required this.bodyController,
    this.senderName = 'AM Adel',
    this.notificationType = 'إشعار جديد',
    this.emptyTitle = 'عنوان الإشعار',
    this.emptyBody = 'نص الإشعار سيظهر هنا...',
  });

  final TextEditingController titleController;
  final TextEditingController bodyController;

  final String senderName;
  final String notificationType;
  final String emptyTitle;
  final String emptyBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColor.border.withOpacity(.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildPreview(context),
          const SizedBox(height: 14),
          _buildHint(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.visibility_outlined,
          color: AppColor.mainColor,
          size: 20,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المعاينة',
                style: StyleManager.font16Weight700(context).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'هكذا سيظهر الإشعار للعميل',
                style: StyleManager.font11Weight400(context).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.border.withOpacity(.25),
        ),
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          titleController,
          bodyController,
        ]),
        builder: (context, _) {
          final title = titleController.text.trim();
          final body = bodyController.text.trim();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.local_pizza_rounded,
                      color: AppColor.textOnDark,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          senderName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font13Weight600(context)
                              .copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              notificationType,
                              style:
                              StyleManager.font11Weight400(context)
                                  .copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: AppColor.textSecondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              'الآن',
                              style:
                              StyleManager.font11Weight400(context)
                                  .copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              Container(
                width: double.infinity,
                height: 1,
                color: AppColor.border.withOpacity(.25),
              ),
              const SizedBox(height: 16),
              Text(
                title.isEmpty ? emptyTitle : title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font16Weight700(context).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                body.isEmpty ? emptyBody : body,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font12Weight500(context).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColor.mainColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'AM Adel Notifications',
                    style: StyleManager.font11Weight400(context).copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHint(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.info_outline_rounded,
          color: AppColor.textSecondary,
          size: 15,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'المعاينة تتحدث تلقائيًا أثناء كتابة الإشعار.',
            style: StyleManager.font11Weight400(context).copyWith(
              color: AppColor.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}