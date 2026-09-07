import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/custom_is_featured.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/custom_is_organic.dart';

class ProductSettingsSection extends StatelessWidget {
  const ProductSettingsSection({
    super.key,
    required this.descriptionController,
    required this.isFeatured,
     this.onDescriptionSaved,
    required this.onFeaturedChanged,
  });

  final TextEditingController descriptionController;

  final bool isFeatured;

  final FormFieldSetter<String> ?onDescriptionSaved;

  final VoidCallback onFeaturedChanged;

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      icon: Icons.settings_outlined,
      label: 'اعدادات اضافيه',
      subLabel: 'خصائص ومميزات المنتج',
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomTextFormField(
              controller: descriptionController,
              label: 'وصف المنتج',
              hintText: 'اكتب وصف المنتج',
              maxLines: 5,
              onSaved: onDescriptionSaved,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الحقل مطلوب';
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: CustomIsFeatured(
                    isFeatured: isFeatured,
                    onTap: onFeaturedChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}