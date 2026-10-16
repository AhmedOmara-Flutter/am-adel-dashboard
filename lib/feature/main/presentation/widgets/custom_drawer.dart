import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';
import 'custom_drawer_desktop.dart';
import 'custom_drawer_mobile.dart';
import 'drawer_item_list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const CustomDrawerDesktop()
        : const CustomDrawerMobile();
  }
}


