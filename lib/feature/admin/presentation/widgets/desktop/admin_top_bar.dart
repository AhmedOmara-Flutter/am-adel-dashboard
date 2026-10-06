import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helper_function/custom_show_snake_bar.dart';
import 'admin_order_comments_button.dart';

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
  final TextEditingController _searchController =
  TextEditingController();

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
            label: 'برجاء مسح جميع السلال أولاً قبل إغلاق المطعم',
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
        final settingsCubit = context.read<SettingsCubit>();
        final isOpen = settingsCubit.isRestaurantOpen;

        final formattedDate =
        DateFormat('dd MMM yyyy').format(DateTime.now());

        return Container(
          margin: const EdgeInsets.only(
              left: 20,
              right: 20,bottom: 10
          ),

          child: Row(
            children: [
              // ───────────────── Profile ─────────────────
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
                        color: AppColor.accentColor.withOpacity(.10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أحمد عمارة',
                          style: StyleManager
                              .font12Weight500(context)
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
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

              // ───────────────── Date ─────────────────
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColor.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formattedDate,
                    style: StyleManager
                        .font11Weight400(context)
                        .copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              // ───────────────── Comments ─────────────────
              AdminOrderCommentsButton(
                commentCount: 3,
                onTap: () {
                  // TODO: Navigate to order comments
                },
              ),

              const SizedBox(width: 14),

              // ───────────────── Restaurant Status ─────────────────
              InkWell(
                onTap: _toggleRestaurantStatus,
                borderRadius: BorderRadius.circular(9),
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
                    borderRadius: BorderRadius.circular(9),
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
                          color: isOpen
                              ? AppColor.green
                              : AppColor.red,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 7),

                      Text(
                        isOpen ? 'مفتوح' : 'مغلق',
                        style: TextStyle(
                          color: isOpen
                              ? AppColor.green
                              : AppColor.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(width: 3),

                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 15,
                        color: isOpen
                            ? AppColor.green
                            : AppColor.red,
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
