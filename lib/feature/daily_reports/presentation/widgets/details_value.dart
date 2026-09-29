import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class DetailValue extends StatelessWidget {
  const DetailValue({
    required this.title,
    required this.value,
    this.highlight = false,
  });

  final String title;
  final double value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.textSecondary,
            fontSize: 8,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '${_formatPrice(value)} ج',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.mainColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    if (price == price.roundToDouble()) {
      return price.toInt().toString();
    }

    return price.toStringAsFixed(2);
  }
}