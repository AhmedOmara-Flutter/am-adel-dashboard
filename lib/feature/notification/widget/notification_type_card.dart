import '../../../core/utils/app_imports.dart';

class NotificationTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String title;
  final String subtitle;
  final String description;
  final Color accent;
  final VoidCallback onTap;

  const NotificationTypeCard({
    required this.icon,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(color: AppColor.border.withOpacity(.32)),
            boxShadow: [
              BoxShadow(
                color: AppColor.mainColor.withOpacity(.035),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(.10),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      icon,
                      color: accent,
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 14),

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
                                style: StyleManager.font16Weight700(
                                  context,
                                ).copyWith(
                                  color: AppColor.textPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(.10),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                label,
                                style: StyleManager.font11Weight400(
                                  context,
                                ).copyWith(
                                  color: accent,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          subtitle,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundDark,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColor.textSecondary,
                      size: 17,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(
                  color: AppColor.textSecondary,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Container(
                    width: 28,
                    height: 3,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'إدارة الإشعارات',
                    style: StyleManager.font11Weight400(
                      context,
                    ).copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.north_east_rounded,
                    color: accent,
                    size: 17,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
