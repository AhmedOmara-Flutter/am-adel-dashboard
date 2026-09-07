import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled
                ? AppColor.card
                : AppColor.mainColor,

            foregroundColor: isDisabled
                ? AppColor.textSecondary
                : AppColor.white,

            disabledBackgroundColor: AppColor.card,
            disabledForegroundColor: AppColor.textSecondary,

            elevation: isDisabled ? 0 : 2,

            side: BorderSide.none,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}