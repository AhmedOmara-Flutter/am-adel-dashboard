import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

import 'clients_view_desktop.dart';
import 'clients_view_mobile.dart';

class ClientsViewBody extends StatelessWidget {
  const ClientsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const ClientsViewDesktop()
        : const ClientsViewMobile();
  }
}


