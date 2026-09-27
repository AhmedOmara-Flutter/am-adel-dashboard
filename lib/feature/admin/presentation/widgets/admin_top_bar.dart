import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../cart_status/presentation/view_model/cart_status_cubit.dart';
import '../../../settings/presentation/view_model/settings_cubit.dart';

class AdminTopBar extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogoutTap;

  const AdminTopBar({
    super.key,
    this.onSearch,
    this.onProfileTap,
    this.onSettingsTap,
    this.onLogoutTap,
  });

  @override
  State<AdminTopBar> createState() => _AdminTopBarState();
}

class _AdminTopBarState extends State<AdminTopBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _toggleRestaurantStatus() async {
    final settingsCubit = context.read<SettingsCubit>();
    final cartStatusCubit = context.read<CartStatusCubit>();

    final isOpen = settingsCubit.isRestaurantOpen;

    // لو المطعم مفتوح وعايزين نقفله
    if (isOpen) {
      await cartStatusCubit.checkCartsStatus();

      final cartState = cartStatusCubit.state;

      if (cartState is CartStatusLoaded) {
        if (cartState.areAllCartsEmpty) {
          await settingsCubit.toggleRestaurantStatus();
        } else {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: 'برجاء مسح جميع السله أولاً قبل إغلاق المطعم',
          );
        }
      } else if (cartState is CartStatusError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ أثناء فحص السلال')),
        );
      }
    } else {
      // لو المطعم مقفول نفتحه مباشرة
      await settingsCubit.toggleRestaurantStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settingsCubit = context.read<SettingsCubit>();

        final bool isOpen = settingsCubit.isRestaurantOpen;

        final String formattedDate = DateFormat(
          'dd MMM yyyy',
        ).format(DateTime.now());

        return Container(
          height: 76,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            border: Border(
              bottom: BorderSide(color: AppColor.border.withOpacity(.5)),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: widget.onProfileTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.10),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: AppColor.mainColor,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 10),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مهندس احمد عماره',
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'مدير المطعم',
                            style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 6),

                      // Arrow
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 17,
                        color: AppColor.textSecondary.withOpacity(.7),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              InkWell(
                onTap: _toggleRestaurantStatus,
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                    color: isOpen
                        ? AppColor.green.withOpacity(.06)
                        : AppColor.red.withOpacity(.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isOpen
                          ? AppColor.green.withOpacity(.16)
                          : AppColor.red.withOpacity(.16),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // =========================
                      // RESTAURANT ICON
                      // =========================
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isOpen
                              ? AppColor.green.withOpacity(.12)
                              : AppColor.red.withOpacity(.12),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(
                          isOpen
                              ? Icons.storefront_rounded
                              : Icons.storefront_outlined,
                          size: 16,
                          color: isOpen ? AppColor.green : AppColor.red,
                        ),
                      ),

                      const SizedBox(width: 9),

                      // =========================
                      // TEXT
                      // =========================
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'حالة المطعم',
                            style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 2),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                            child: Text(
                              isOpen ? 'مفتوح الآن' : 'مغلق الآن',
                              key: ValueKey(isOpen),
                              style: TextStyle(
                                color: isOpen ? AppColor.green : AppColor.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 10),

                      // =========================
                      // STATUS DOT
                      // =========================
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isOpen ? AppColor.green : AppColor.red,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 5),

                      // =========================
                      // ARROW
                      // =========================
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 17,
                        color: isOpen ? AppColor.green : AppColor.red,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // =========================
              // DIVIDER
              // =========================
              Container(
                width: 1,
                height: 28,
                color: AppColor.border.withOpacity(.7),
              ),

              const SizedBox(width: 20),

              // =========================
              // DATE
              // =========================
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 17,
                    color: AppColor.textSecondary,
                  ),

                  const SizedBox(width: 7),

                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }
}
