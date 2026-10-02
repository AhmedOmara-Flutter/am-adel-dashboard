import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProductBasicInfo extends StatelessWidget {
  const ProductBasicInfo({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.onNameSaved,
    required this.onPriceSaved,
  });

  final TextEditingController nameController;
  final TextEditingController priceController;

  final ValueChanged<String?> onNameSaved;
  final ValueChanged<String?> onPriceSaved;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            label: 'اسم المنتج',
            controller: nameController,
            hintText: 'اكتب اسم المنتج',
            onSaved: onNameSaved,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الحقل مطلوب';
              }

              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextFormField(
            label: 'سعر المنتج',
            controller: priceController,
            hintText: 'اكتب سعر المنتج',
            keyboardType: TextInputType.number,
            onSaved: onPriceSaved,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الحقل مطلوب';
              }

              if (num.tryParse(value) == null) {
                return 'ادخل سعر صحيح';
              }

              return null;
            },
          ),
        ),
      ],
    );
  }
}