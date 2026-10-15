import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:am_adel_dashboard/feature/admin/presentation/widgets/desktop/quick_action_button.dart';
import '../../../../../core/widgets/custom_container.dart';
import '../../../../../core/widgets/icon_badge.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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

              const spacing = 10.0;
              final itemWidth = (width - ((columns - 1) * spacing)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: QuickActionButton(
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
                    child: QuickActionButton(
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
                    child: QuickActionButton(
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
                    child: QuickActionButton(
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

