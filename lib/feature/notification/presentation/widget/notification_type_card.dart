import 'package:am_adel_dashboard/core/widgets/custom_container.dart';

import '../../../../core/utils/app_imports.dart';

class NotificationTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String title;
  final String subtitle;
  final String description;
  final Color accent;
  final VoidCallback onTap;

  const NotificationTypeCard({
    super.key,
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: CustomContainer(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(20),
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
                                  maxLines: 2,
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
                          const SizedBox(height: 8),
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
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundDark,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColor.textSecondary,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  width: 42,
                  height: 3,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: StyleManager.font11Weight400(context).copyWith(
                    color: AppColor.textSecondary,
                    height: 1.8,
                  ),
                ),
                const Spacer(),
                Divider(
                  color: AppColor.divider.withOpacity(.5),
                  height: 28,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      color: accent,
                      size: 19,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'إدارة الإشعارات',
                        style: StyleManager.font11Weight400(
                          context,
                        ).copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.north_east_rounded,
                      color: accent,
                      size: 19,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
