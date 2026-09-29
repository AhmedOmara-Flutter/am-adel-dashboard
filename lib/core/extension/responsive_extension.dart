import 'package:flutter/material.dart';
import '../utils/config_size.dart';

extension ResponsiveExtension on BuildContext {
  bool get isDesktop =>
      MediaQuery.sizeOf(this).width > ConfigSize.phone;
}