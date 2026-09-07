import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';

class ProductBasicInfoSection extends StatelessWidget {
  const ProductBasicInfoSection({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
     this.onNameSaved,
     this.onPriceSaved,
  });

  final TextEditingController nameController;
  final TextEditingController priceController;
  final String? selectedCategory;
  final List<DropdownMenuItem<String>> categories;

  final ValueChanged<String?> onCategoryChanged;
  final FormFieldSetter<String> ?onNameSaved;
  final FormFieldSetter<String>?onPriceSaved;

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      icon: Icons.local_offer_outlined,
      label: 'معلومات المنتج',
      subLabel: 'البيانات الأساسية للمنتج',
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'اسم المنتج',
                    controller: nameController,
                    hintText: 'اكتب اسم المنتج',
                    onSaved: onNameSaved,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
            if (value == null || value.isEmpty) {
              return 'الحقل مطلوب';
            }
            return null;
          },
        ),
      ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Text(
                  'التصنيف',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 2,
                ),
              ],
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: Text(
                'اختر التصنيف',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onChanged: onCategoryChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'برجاء اختيار التصنيف';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}