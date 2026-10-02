import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProductFormButton extends StatelessWidget {
  const ProductFormButton({
    super.key,
    required this.isEnabled,
    this.onPressed,
    required this.label,
  });

  final bool isEnabled;
  final VoidCallback ?onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        label,
        style: StyleManager
            .font15Weight800(context)
            .copyWith(
          color: AppColor.white,
        ),
      ),
    );
  }
}