import 'package:flutter/material.dart';
import '../../../../core/extension/responsive_extension.dart';
import 'desktop/admin_view_desktop.dart';
import 'mobile/admin_view_mobile.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const AdminViewDesktop()
        : const AdminViewMobile();
  }
}
