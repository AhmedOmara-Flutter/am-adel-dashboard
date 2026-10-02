import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.controller,
    required this.onSaved,
  });

  final TextEditingController controller;
  final ValueChanged<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      label: 'وصف المنتج',
      hintText: 'اكتب وصف المنتج',
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'الحقل مطلوب';
        }

        return null;
      },
      maxLines: 4,
    );
  }
}