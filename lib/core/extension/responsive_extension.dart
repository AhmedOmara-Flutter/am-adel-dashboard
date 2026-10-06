import 'package:flutter/material.dart';
import '../utils/config_size.dart';

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isPhone => screenWidth < ConfigSize.phone;

  bool get isTablet =>
      screenWidth >= ConfigSize.phone &&
          screenWidth < ConfigSize.tablet;

  bool get isDesktop => screenWidth >= ConfigSize.tablet;
}
