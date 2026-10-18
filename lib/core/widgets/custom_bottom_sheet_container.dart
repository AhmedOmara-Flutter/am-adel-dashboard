import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/style_manager.dart';

class CustomBottomSheetContainer extends StatelessWidget {
  const CustomBottomSheetContainer({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.icon,
    this.maxHeightFactor = 0.9,
    this.padding = const EdgeInsets.fromLTRB(18, 10, 18, 20),
    this.showHandle = true,
    this.headerSpacing = 20,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final double maxHeightFactor;
  final EdgeInsetsGeometry padding;
  final bool showHandle;
  final double headerSpacing;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final showHeader = title != null && subtitle != null && icon != null;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: mediaQuery.viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
            mediaQuery.size.height * maxHeightFactor,
          ),
          child: SingleChildScrollView(
            padding: padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showHandle) ...[
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColor.textSecondary,
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                if (showHeader) ...[
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(
                          icon!,
                          color: AppColor.mainColor,
                          size: 23,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title!,
                              style: StyleManager
                                  .font18Weight700(context)
                                  .copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              subtitle!,
                              style: StyleManager
                                  .font12Weight500(context)
                                  .copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: headerSpacing),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
