import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../cart_status/presentation/view_model/cart_status_cubit.dart';
import '../view_model/settings_cubit.dart';

class RestaurantStatusCard extends StatelessWidget {
  const RestaurantStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settingsCubit = context.read<SettingsCubit>();
        final cartStatusCubit = context.read<CartStatusCubit>();

        final isOpen = settingsCubit.isRestaurantOpen;

        final statusColor =
        isOpen ? AppColor.green : AppColor.red;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: statusColor.withOpacity(.18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'حالة المطعم',
                          style: StyleManager.font19Weight700(
                            context,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'تحكم في استقبال الطلبات',
                          style: StyleManager.font12Weight500(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

// Status Badge
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration:
                          const Duration(milliseconds: 300),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          isOpen ? 'مفتوح' : 'مغلق',
                          style:
                          StyleManager.font12Weight500(context)
                              .copyWith(
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.055),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: statusColor.withOpacity(.10),
                  ),
                ),
                child: Row(
                  children: [
// Status Icon
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(.10),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isOpen
                            ? Icons.storefront_rounded
                            : Icons.storefront_outlined,
                        color: statusColor,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 13),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            isOpen
                                ? 'المطعم يستقبل الطلبات'
                                : 'المطعم لا يستقبل الطلبات',
                            style:
                            StyleManager.font15Weight700(
                              context,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isOpen
                                ? 'يمكن للعملاء إنشاء طلبات جديدة'
                                : 'لن يتم استقبال طلبات جديدة',
                            style:
                            StyleManager.font11Weight400(
                              context,
                            ).copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () async {
                      if (isOpen) {
                        await cartStatusCubit
                            .checkCartsStatus();

                        final cartState =
                            cartStatusCubit.state;

                        if (cartState is CartStatusLoaded) {
                          if (cartState.areAllCartsEmpty) {
                            await settingsCubit
                                .toggleRestaurantStatus();
                          } else {
                            customShowSnakeBar(
                              context,
                              color: AppColor.red,
                              label:
                              'برجاء مسح جميع السله أولاً قبل إغلاق المطعم',
                            );
                          }
                        } else if (cartState
                        is CartStatusError) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'حدث خطأ أثناء فحص السلال',
                              ),
                            ),
                          );
                        }
                      } else {
                        await settingsCubit
                            .toggleRestaurantStatus();
                      }
                    },
                    child: AnimatedContainer(
                      duration:
                      const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(.09),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            isOpen
                                ? Icons.lock_outline_rounded
                                : Icons.lock_open_rounded,
                            color: statusColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isOpen
                                ? 'إغلاق المطعم'
                                : 'فتح المطعم',
                            style:
                            StyleManager.font13Weight400(
                              context,
                            ).copyWith(
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
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
