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
            backgroundColor: AppColor.mainColor,
            foregroundColor: AppColor.white,

            disabledBackgroundColor:
            AppColor.mainColor.withOpacity(.5),

            disabledForegroundColor:
            AppColor.white.withOpacity(.6),

            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}