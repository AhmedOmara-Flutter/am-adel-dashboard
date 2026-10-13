import 'package:am_adel_dashboard/feature/settings/presentation/widgets/settings_desktop_layout.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/settings_mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/build_copy_right.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/print_settings_tile.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/restaurant_status_card.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/setting_danger_card.dart';
import '../../../../core/extension/responsive_extension.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../generated/assets.dart';
import '../../../cart_status/presentation/view_model/cart_status_cubit.dart';
import 'manager_info_card.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  String version = "0.0.0";

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    final info = await PackageInfo.fromPlatform();

    if (!mounted) return;

    setState(() {
      version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: context.isDesktop
              ? SettingsDesktopLayout()
              : SettingsMobileLayout(),

    );
  }
}