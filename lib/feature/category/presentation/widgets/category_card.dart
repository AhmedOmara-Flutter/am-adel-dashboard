import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.border.withOpacity(.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.10),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: AppColor.mainColor.withOpacity(.18),
                  ),
                ),
                child: const Icon(
                  Icons.category_rounded,
                  color: AppColor.mainColor,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            category.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font15Weight700(
                              context,
                            ).copyWith(color: AppColor.textPrimary),
                          ),
                        ),

                        if (category.sizes.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.mainColor.withOpacity(.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColor.mainColor.withOpacity(.16),
                              ),
                            ),
                            child: Text(
                              '${category.sizes.length}',
                              style: StyleManager.font13Weight600(
                                context,
                              ).copyWith(color: AppColor.mainColor),
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 9),

                    if (category.sizes.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: category.sizes.map((size) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.accentColor.withOpacity(.09),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColor.accentColor.withOpacity(.16),
                              ),
                            ),
                            child: Text(
                              size,
                              style: StyleManager.font13Weight600(
                                context,
                              ).copyWith(color: AppColor.accentColor),
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.background.withOpacity(.55),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColor.border.withOpacity(.7),
                          ),
                        ),
                        child: Text(
                          'لا توجد مقاسات',
                          style: StyleManager.font13Weight600(
                            context,
                          ).copyWith(color: AppColor.textSecondary),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Material(
                color: AppColor.mainColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: dragHandle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.edit_outlined,
                  color: AppColor.green,
                  onTap: onEdit,
                ),
              ),

              const SizedBox(width: 7),

              Expanded(
                child: _ActionButton(
                  icon: Icons.delete_outline_rounded,
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(.09),
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        splashColor: color.withOpacity(.15),
        highlightColor: color.withOpacity(.06),
        child: SizedBox(
          height: 35,
          child: Center(child: Icon(icon, color: color, size: 18)),
        ),
      ),
    );
  }
}
