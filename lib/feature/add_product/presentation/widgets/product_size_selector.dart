import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/category/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class ProductSizeSelector extends StatelessWidget {
  const ProductSizeSelector({
    super.key,
    required this.category,
    required this.selectedSize,
    required this.onChanged,
  });

  final CategoryEntity? category;
  final String? selectedSize;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (category == null || category!.sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    final sizes = category!.sizes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'الحجم',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                color: AppColor.mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              backgroundColor: AppColor.red,
              radius: 2,
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue:
          sizes.contains(selectedSize) ? selectedSize : null,
          hint: Text(
            'اختر الحجم',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
              color: AppColor.textSecondary,
            ),
          ),
          items: sizes.map((size) {
            return DropdownMenuItem<String>(
              value: size,
              child: Text(
                size,
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
              return 'برجاء اختيار الحجم';
            }

            return null;
          },
        ),
      ],
    );
  }
}