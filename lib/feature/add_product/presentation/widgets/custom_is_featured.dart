import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';

class CustomIsFeatured extends StatelessWidget {
  final bool isFeatured;
  final Function()? onTap;

  const CustomIsFeatured({
    super.key,
    required this.isFeatured,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isFeatured
                  ? AppColor.mainColor
                  : AppColor.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.border,
              ),
            ),
            child: isFeatured
                ? Icon(
              Icons.done,
              size: 17,
              color: AppColor.white,
            )
                : null,
          ),
          Text(
            'المنتج مميز',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}