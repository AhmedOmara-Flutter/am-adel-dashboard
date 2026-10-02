import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../category/presentation/view_model/category_cubit.dart';

class ProductCategorySelector extends StatelessWidget {
  const ProductCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories =
            context.watch<CategoryCubit>().categories;

        if (state is CategoryGetLoading && categories.isEmpty) {
          return Container(
            height: 55,
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.divider,
              ),
            ),
            child: const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColor.accentColor,
                ),
              ),
            ),
          );
        }

        if (categories.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.divider,
              ),
            ),
            child: Text(
              'لا توجد تصنيفات متاحة',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(
                color: AppColor.textSecondary,
              ),
            ),
          );
        }

        final validValue = categories.any(
              (category) => category.id == selectedCategory,
        )
            ? selectedCategory
            : null;

        return DropdownButtonFormField<String>(
          initialValue: validValue,
          hint: Text(
            'اختر التصنيف',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
              color: AppColor.textSecondary,
            ),
          ),
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category.id,
              child: Text(
                category.name,
                style: const TextStyle(
                  color: AppColor.textPrimary,
                ),
              ),
            );
          }).toList(),
          dropdownColor: AppColor.cardLight,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(
            color: AppColor.textPrimary,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.textSecondary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.cardLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.divider,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.accentColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.red,
                width: 1.5,
              ),
            ),
          ),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'برجاء اختيار التصنيف';
            }

            return null;
          },
          onSaved: onChanged,
        );
      },
    );
  }
}