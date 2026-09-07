import 'package:flutter/cupertino.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';

class ProductPricingSection extends StatelessWidget {
  const ProductPricingSection({
    super.key,
    required this.priceController,
    required this.expirationMonthController,
    required this.unitAmountController,
    required this.numberOfCaloriesController,
    this.onPriceSaved,
    this.onExpirationSaved,
    this.onUnitAmountSaved,
    this.onCaloriesSaved,
  });

  final TextEditingController priceController;
  final TextEditingController expirationMonthController;
  final TextEditingController unitAmountController;
  final TextEditingController numberOfCaloriesController;

  final FormFieldSetter<String>?onPriceSaved;
  final FormFieldSetter<String>?onExpirationSaved;
  final FormFieldSetter<String>?onUnitAmountSaved;
  final FormFieldSetter<String>?onCaloriesSaved;

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      icon: CupertinoIcons.cart,
      label: 'التسعير والمخزون',
      subLabel: 'السعر والكميه والقيم الغذائيه للمنتج',
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
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
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextFormField(
                    label: 'تاريخ الانتهاء',
                    controller: expirationMonthController,
                    hintText: 'اكتب تاريخ الانتهاء',
                    keyboardType: TextInputType.number,
                    onSaved: onExpirationSaved,
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
                Expanded(
                  child: CustomTextFormField(
                    label: 'عدد الوحدات',
                    controller: unitAmountController,
                    hintText: 'اكتب عدد الوحدات',
                    keyboardType: TextInputType.number,
                    onSaved: onUnitAmountSaved,
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
                    label: 'عدد السعرات',
                    controller: numberOfCaloriesController,
                    hintText: 'اكتب عدد السعرات',
                    keyboardType: TextInputType.number,
                    onSaved: onCaloriesSaved,
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
          ],
        ),
      ),
    );
  }
}