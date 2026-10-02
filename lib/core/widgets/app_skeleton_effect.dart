import 'package:skeletonizer/skeletonizer.dart';
import '../utils/app_color.dart';

class AppSkeletonEffect {
  const AppSkeletonEffect._();

  static ShimmerEffect get shimmer => ShimmerEffect(
    baseColor: AppColor.backgroundDark.withOpacity(.30),
    highlightColor: AppColor.cardLight,
    duration: const Duration(milliseconds: 1300),
  );
}
