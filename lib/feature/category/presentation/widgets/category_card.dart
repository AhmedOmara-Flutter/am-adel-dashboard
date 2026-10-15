import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/action_button.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../domain/entities/category_entity.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.dragHandle,
    required this.onEdit,
    required this.onDelete,
  });

  final CategoryEntity category;
  final Widget dragHandle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final hasSizes = category.sizes.isNotEmpty;

    return CustomContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              _CategoryIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: _CategoryHeader(category: category, hasSizes: hasSizes),
              ),
              const SizedBox(width: 10),
              _DragHandle(child: dragHandle),
            ],
          ),
          SizedBox(height: 10),
          if (hasSizes) _Sizes(sizes: category.sizes),
          SizedBox(height: 10),

          Container(height: 1, color: AppColor.divider.withOpacity(.25)),
          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ActionButton(
                  icon: Icons.edit_outlined,
                  label: 'تعديل',
                  color: AppColor.mainColor,
                  onTap: onEdit,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ActionButton(
                  icon: Icons.delete_outline_rounded,
                  label: 'حذف',
                  color: AppColor.red,
                  onTap: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: AppColor.mainColor.withOpacity(.07),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.category_outlined,
        color: AppColor.mainColor,
        size: 22,
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final CategoryEntity category;
  final bool hasSizes;

  const _CategoryHeader({required this.category, required this.hasSizes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          category.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font16Weight700(
            context,
          ).copyWith(color: AppColor.textPrimary),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              hasSizes
                  ? Icons.check_circle_outline_rounded
                  : Icons.info_outline_rounded,
              size: 14,
              color: hasSizes
                  ? AppColor.accentColor
                  : AppColor.textSecondary.withOpacity(.6),
            ),
            const SizedBox(width: 5),
            Text(
              hasSizes
                  ? '${category.sizes.length} مقاسات متاحة'
                  : 'لا توجد مقاسات',
              style: StyleManager.font11Weight400(context).copyWith(
                color: hasSizes
                    ? AppColor.textSecondary
                    : AppColor.textSecondary.withOpacity(.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Sizes extends StatelessWidget {
  final List<String> sizes;

  const _Sizes({required this.sizes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: sizes.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 7);
        },
        itemBuilder: (context, index) {
          return _SizeItem(size: sizes[index]);
        },
      ),
    );
  }
}

class _SizeItem extends StatelessWidget {
  final String size;

  const _SizeItem({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.backgroundDark.withOpacity(.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.accentColor.withOpacity(.16)),
      ),
      alignment: Alignment.center,
      child: Text(
        size,
        style: StyleManager.font11Weight400(
          context,
        ).copyWith(color: AppColor.mainColor),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  final Widget child;

  const _DragHandle({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.backgroundDark.withOpacity(.35),
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(width: 36, height: 36, child: Center(child: child)),
    );
  }
}

