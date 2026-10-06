import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_constants.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.border.withOpacity(.28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.025),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColor.accentColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.flash_on_rounded,
                  color: AppColor.accentColor,
                  size: 17,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'إجراءات سريعة',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final columns = width >= 850
                  ? 4
                  : width >= 600
                  ? 2
                  : 1;

              const spacing = 8.0;

              final itemWidth =
                  (width - ((columns - 1) * spacing)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: 8,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'إضافة منتج',
                      icon: Icons.add_rounded,
                      onTap: () {
                        context.read<MainCubit>().changeIndex(3);                      },
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'إنشاء عرض',
                      icon: Icons.card_giftcard_outlined,
                      onTap: () {
                        context.read<MainCubit>().changeIndex(2);
                      },
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'إضافة كوبون',
                      icon: Icons.local_offer_outlined,
                      onTap: () {
                        context.read<MainCubit>().changeIndex(13);
                      },
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _QuickActionButton(
                      title: 'التقرير اليومي',
                      icon: Icons.description_outlined,
                      onTap: () {
                        context.read<MainCubit>().changeIndex(12);
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
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
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
      onEnter: (_) {
        setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: 44,
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColor.background
              : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? AppColor.accentColor.withOpacity(.45)
                : AppColor.divider.withOpacity(.45),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                children: [
                  Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 16,
                      color: AppColor.mainColor,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: AppColor.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? AppColor.accentColor.withOpacity(.14)
                          : AppColor.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 8,
                      color: _isHovered
                          ? AppColor.mainColor
                          : AppColor.textSecondary,
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