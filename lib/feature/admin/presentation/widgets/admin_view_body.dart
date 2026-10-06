import 'package:flutter/material.dart';

import '../../../../core/extension/responsive_extension.dart';
import 'desktop/admin_view_desktop.dart';
import 'mobile/admin_view_mobile.dart';
import 'tablet/admin_view_tablet.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return const AdminViewDesktop();
    }

    if (context.isTablet) {
      return const AdminViewTablet();
    }

    return const AdminViewMobile();
  }
}
