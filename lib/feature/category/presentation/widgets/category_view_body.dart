import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../generated/assets.dart';
import '../../domain/entities/category_entity.dart';
import '../view_model/category_cubit.dart';
import 'category_card.dart';
import 'edit_category_bottom_sheet.dart';

class CategoryViewBody extends StatelessWidget {
  const CategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryGetLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.mainColor,
              strokeWidth: 2,
            ),
          );
        }

        if (state is CategoryGetError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColor.red),
            ),
          );
        }

        final categories = context.read<CategoryCubit>().categories;

        if (categories.isEmpty) {
          return Center(child: Lottie.asset(Assets.assets.json.empty));
        }

        return ReorderableListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: categories.length,
          buildDefaultDragHandles: false,
          onReorder: (oldIndex, newIndex) async {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }

            final reorderedCategories = List<CategoryEntity>.from(categories);

            final category = reorderedCategories.removeAt(oldIndex);

            reorderedCategories.insert(newIndex, category);

            await context.read<CategoryCubit>().updateCategoriesOrder(
              reorderedCategories,
            );
          },
          itemBuilder: (context, index) {
            final category = categories[index];
            return Container(
              key: ValueKey(category.id),
              margin: const EdgeInsets.only(bottom: 14),
              child: CategoryCard(
                category: category,
                dragHandle: ReorderableDragStartListener(
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.drag_handle_rounded,
                      color: AppColor.textSecondary.withOpacity(.65),
                      size: 20,
                    ),
                  ),
                ),
                onEdit: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColor.background,
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<CategoryCubit>(),
                        child: EditCategoryBottomSheet(category: category),
                      );
                    },
                  );
                },
                onDelete: () {
                  CustomShowDialog.show(
                    context,
                    title: 'حذف التصنيف',
                    content: Text(
                      'هل أنت متأكد أنك تريد حذف "${category.name}"؟',
                      textAlign: TextAlign.center,
                      style: StyleManager.font13Weight600(context),
                    ),
                    cancel: () {
                      Navigator.pop(context);
                    },
                    accept: () async {
                      Navigator.pop(context);

                      await context.read<CategoryCubit>().deleteCategory(
                        category.id,
                      );
                    },
                    flag: Icons.category_outlined,
                    color: AppColor.red,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
