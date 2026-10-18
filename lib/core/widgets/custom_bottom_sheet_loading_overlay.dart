import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class CustomBottomSheetLoadingOverlay extends StatelessWidget {
  const CustomBottomSheetLoadingOverlay({
    super.key,
    this.backgroundOpacity = 0.25,
    this.loaderSize = 70,
  });

  final double backgroundOpacity;
  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AbsorbPointer(
        child: Container(
          color: AppColor.mainColor.withOpacity(backgroundOpacity),
          child: Center(
            child: Container(
              width: loaderSize,
              height: loaderSize,
              decoration: BoxDecoration(
                color: AppColor.cardLight,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColor.accentColor.withOpacity(0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  width: loaderSize * 0.46,
                  height: loaderSize * 0.46,
                  child: const CircularProgressIndicator(
                    color: AppColor.mainColor,
                    strokeWidth: 3,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
