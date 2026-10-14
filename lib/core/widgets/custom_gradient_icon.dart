import 'package:am_adel_dashboard/core/utils/app_imports.dart';

class CustomGradientIcon extends StatelessWidget {
  const CustomGradientIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.borderRadius,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.accentColor,
            AppColor.goldLight,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentColor.withOpacity(.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: AppColor.mainColor,
        size: iconSize,
      ),
    );
  }
}