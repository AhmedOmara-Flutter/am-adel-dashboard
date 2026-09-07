import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';

class ProductDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final String? subValue;
  final Color? subValueColor;

  const ProductDetailItem({
    super.key,
    required this.title,
    required this.value,
    this.subValue,
    this.subValueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColor.mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (subValue != null)
          Text(
            subValue!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColor.mainColor,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}
