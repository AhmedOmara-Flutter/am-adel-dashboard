import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
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

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isOpen
                  ? AppColor.green.withOpacity(.20)
                  : AppColor.red.withOpacity(.20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.secondaryColor.withOpacity(.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: isOpen
                          ? AppColor.green.withOpacity(.10)
                          : AppColor.red.withOpacity(.10),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      isOpen
                          ? Icons.storefront_rounded
                          : Icons.storefront_outlined,
                      color: isOpen ? AppColor.green : AppColor.red,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'حالة المطعم',
                          style: StyleManager.font19Weight700(context),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isOpen
                                    ? AppColor.green
                                    : AppColor.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              isOpen
                                  ? 'المطعم مفتوح الآن'
                                  : 'المطعم مغلق الآن',
                              style: StyleManager.font13Weight600(context)
                                  .copyWith(
                                color: isOpen
                                    ? AppColor.green
                                    : AppColor.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: isOpen
                      ? AppColor.green.withOpacity(.08)
                      : AppColor.red.withOpacity(.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
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
                              label:
                              'برجاء مسح جميع السله أولاً قبل إغلاق المطعم',
                            );
                          }
                        } else if (cartState is CartStatusError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'حدث خطأ أثناء فحص السلال',
                              ),
                            ),
                          );
                        }
                      } else {
                        await settingsCubit.toggleRestaurantStatus();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isOpen
                              ? Icons.lock_rounded
                              : Icons.lock_open_rounded,
                          color: isOpen
                              ? AppColor.green
                              : AppColor.red,
                          size: 21,
                        ),

                        const SizedBox(width: 9),

                        Text(
                          isOpen
                              ? 'إغلاق المطعم'
                              : 'فتح المطعم',
                          style: StyleManager.font15Weight800(context)
                              .copyWith(
                            color: isOpen
                                ? AppColor.green.withOpacity(0.8)
                                : AppColor.red.withOpacity(0.8),
                          ),
                        ),
                      ],
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