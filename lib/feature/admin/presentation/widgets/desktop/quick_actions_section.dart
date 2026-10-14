import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import '../../../../../core/widgets/icon_badge.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.divider.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(
                icon: Icons.bolt_rounded,
                iconColor: AppColor.mainColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إجراءات سريعة',
                      style: StyleManager.font13Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColor.accentColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColor.accentColor.withOpacity(.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColor.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '4 اختصارات',
                      style: StyleManager.font11Weight400(context).copyWith(
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final columns = width >= 850
                  ? 4
                  : width >= 500
                  ? 2
                  : 1;

              const spacing = 12.0;
              final itemWidth = (width - ((columns - 1) * spacing)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'إضافة منتج',
                      subtitle: 'أضف منتجًا جديدًا',
                      icon: Icons.add_box_rounded,
                      index: '01',
                      onTap: () {
                        context.read<MainCubit>().changeIndex(3);
                      },
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'إنشاء عرض',
                      subtitle: 'جهّز عرضًا جديدًا',
                      icon: Icons.card_giftcard_rounded,
                      index: '02',
                      onTap: () {
                        context.read<MainCubit>().changeIndex(2);
                      },
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'إضافة كوبون',
                      subtitle: 'أنشئ كود خصم',
                      icon: Icons.confirmation_number_rounded,
                      index: '03',
                      onTap: () {
                        context.read<MainCubit>().changeIndex(14);
                      },
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'التقرير اليومي',
                      subtitle: 'تابع ملخص اليوم',
                      icon: Icons.analytics_rounded,
                      index: '04',
                      onTap: () {
                        context.read<MainCubit>().changeIndex(13);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  const _QuickActionButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.index,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String index;
  final VoidCallback onTap;

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: _isHovered ? AppColor.background : AppColor.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? AppColor.accentColor.withOpacity(.65)
                : AppColor.divider.withOpacity(0.25),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColor.accentColor.withOpacity(.12),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: _isHovered
                          ? const LinearGradient(
                              colors: [
                                AppColor.accentColor,
                                AppColor.goldLight,
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            )
                          : null,
                      color: _isHovered
                          ? null
                          : AppColor.accentColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 23,
                      color: AppColor.mainColor,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font12Weight500(context).copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? AppColor.accentColor.withOpacity(.2)
                          : AppColor.backgroundDark.withOpacity(.65),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11,
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
