import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../cart_status/presentation/view_model/cart_status_cubit.dart';
import '../../../../settings/presentation/view_model/settings_cubit.dart';

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
          const SnackBar(
            content: Text('حدث خطأ أثناء فحص السلال'),
          ),
        );
      }
    } else {
      await settingsCubit.toggleRestaurantStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isOpen =
            context.read<SettingsCubit>().isRestaurantOpen;

        final formattedDate =
        DateFormat('dd MMM yyyy').format(DateTime.now());

        return Container(
          height: 68,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadius,
            ),
            border: Border.all(
              color: AppColor.border.withOpacity(.35),
            ),
          ),
          child: Row(
            children: [
              // Profile
              InkWell(
                onTap: widget.onProfileTap,
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withOpacity(.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppColor.mainColor,
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 9),

                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'احمد عماره',
                          style:StyleManager.font12Weight500(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.textPrimary
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'مدير المطعم',
                          style: TextStyle(
                            color: AppColor.textSecondary,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Date
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: AppColor.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 18),

              // Restaurant Status
              InkWell(
                onTap: _toggleRestaurantStatus,
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isOpen
                        ? AppColor.green.withOpacity(.07)
                        : AppColor.red.withOpacity(.07),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isOpen
                          ? AppColor.green.withOpacity(.18)
                          : AppColor.red.withOpacity(.18),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color:
                          isOpen ? AppColor.green : AppColor.red,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 7),

                      Text(
                        isOpen ? 'مفتوح' : 'مغلق',
                        style: TextStyle(
                          color:
                          isOpen ? AppColor.green : AppColor.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(width: 4),

                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 15,
                        color:
                        isOpen ? AppColor.green : AppColor.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}