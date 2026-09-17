import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class CustomIsFeatured extends StatelessWidget {
  const CustomIsFeatured({
    super.key,
    required this.isFeatured,
    this.onTap,
  });

  final bool isFeatured;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isFeatured
                    ? AppColor.mainColor
                    : AppColor.cardLight,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: isFeatured
                      ? AppColor.mainColor
                      : AppColor.border,
                  width: 1.2,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: isFeatured
                    ? const Icon(
                  Icons.check_rounded,
                  key: ValueKey(true),
                  size: 17,
                  color: AppColor.textOnDark,
                )
                    : const SizedBox(
                  key: ValueKey(false),
                ),
              ),
            ),
            const SizedBox(width: 9),
            Text(
              'المنتج مميز',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
