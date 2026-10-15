import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/app_constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 1,
    this.boxShadow,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.onTap,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final VoidCallback? onTap;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppConstants.borderRadius;

    return Container(
      height: height,
      width: width,
      margin: margin,
      alignment: alignment,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: color ?? AppColor.cardLight,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? AppColor.divider.withOpacity(0.25),
          width: borderWidth,
        ),
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: clipBehavior,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          hoverColor: hoverColor,
          splashColor: splashColor,
          highlightColor: highlightColor,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
