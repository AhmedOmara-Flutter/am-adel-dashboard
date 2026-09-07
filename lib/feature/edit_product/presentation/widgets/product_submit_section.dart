import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/widgets/custom_button.dart';

class ProductSubmitSection extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const ProductSubmitSection({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}