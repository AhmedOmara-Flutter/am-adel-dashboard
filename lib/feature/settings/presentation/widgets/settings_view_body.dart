import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/build_copy_right.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/print_settings_tile.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/restaurant_status_card.dart';
import 'package:am_adel_dashboard/feature/settings/presentation/widgets/setting_danger_card.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > ConfigSize.phone;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: isDesktop
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: AppColor.black,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColor.mainColor.withOpacity(
                  AppConstants.borderColor,
                ),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: AppColor.border,
              ),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            Assets.assets.images.appLogo2.path,
            height: 220,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 50),
        const ManagerInfoCard(
          name: 'سفيان محمد',
          phone: '01150279072',
        ),
        const SizedBox(height: 15),
        const RestaurantStatusCard(),
        const SizedBox(height: 30),
        const PrintSettingsTile(),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: buildOrdersDangerCard(context),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: buildCartDangerCard(context),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: buildBundleOffersDangerCard(context),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: buildOffersDangerCard(context),
            ),
          ],
        ),
        const SizedBox(height: 50),
        const BuildCopyRight(),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const ManagerInfoCard(
          name: 'سفيان محمد',
          phone: '01150279072',
        ),
        const SizedBox(height: 15),
        const RestaurantStatusCard(),
        // const SizedBox(height: 15),
        // const PrintSettingsTile(),
        const SizedBox(height: 15),
        Column(
          children: [
            buildOrdersDangerCard(context),

            const SizedBox(height: 15),

            buildCartDangerCard(context),

            const SizedBox(height: 15),

            buildBundleOffersDangerCard(context),

            const SizedBox(height: 15),

            buildOffersDangerCard(context),
          ],
        ),
        const SizedBox(height: 30),
        const BuildCopyRight(),
        const SizedBox(height: 20),
      ],
    );
  }
}